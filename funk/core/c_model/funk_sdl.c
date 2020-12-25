#include <SDL2/SDL.h>
#if FUNK_BUILD_FOR_WEB
#include <emscripten.h>
#include <emscripten/html5.h>
#endif

#include "funk_sdl.h"
#include "funk_c_model.h"

struct sdl_context
{

    struct tnode user_data;

};

SDL_Renderer *renderer = NULL;


struct tnode g_sdl_user_global_state;

void sdl_render(struct tnode *, int32_t, struct tnode *);
void funk_create_int_scalar(enum pool_types , struct tnode * , int32_t );


void set_sdl_user_global_state(struct tnode * state)
{

  funk_copy_node( &g_sdl_user_global_state, state);

}
void sdl_set_color(struct tnode * r, struct tnode * g, struct tnode * b){
  SDL_SetRenderDrawColor(renderer,
    GET_NODE(r,0)->data.i,
    GET_NODE(g,0)->data.i,
    GET_NODE(b,0)->data.i, 255 );
}

void sdl_rect(struct tnode * x, struct tnode * y, struct tnode * w,struct tnode * h){
  SDL_Rect r;
  r.x = GET_NODE(x,0)->data.i;
  r.y = GET_NODE(y,0)->data.i;
  r.w = GET_NODE(w,0)->data.i;
  r.h = GET_NODE(h,0)->data.i;

  SDL_RenderFillRect(renderer, &r );
}

void sdl_render_loop(void *arg)
{

    // black background
    SDL_SetRenderDrawColor(renderer, 100, 100, 100, 255);
    SDL_RenderClear(renderer);

    struct tnode result;
    funk_create_int_scalar(function_pool, &result, 0);

    sdl_render(&result, 1, &g_sdl_user_global_state);
    SDL_RenderPresent(renderer);

}

// The event handler functions can return 1 to suppress the event and disable the default action. That calls event.preventDefault();
// Returning 0 signals that the event was not consumed by the code, and will allow the event to pass on and bubble up normally.
EM_BOOL key_callback(int eventType, const EmscriptenKeyboardEvent *e, void *userData)
{
  printf("In Weeeeeeeeeee\n");
  // Take a lool at
  //https://chromium.googlesource.com/external/github.com/kripken/emscripten/+/refs/tags/1.36.0/tests/test_html5_fullscreen.c
  return 0;
}

void funk_sdl_create_window(int32_t w, int32_t h, struct tnode * user_data)
{
    printf("-I- Initializing SDL 2D\n");

    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Couldn't initialize SDL: %s", SDL_GetError());
    }
    SDL_Window *window;
    //SDL_Renderer *renderer;

    emscripten_set_keypress_callback("#canvas", 0, 0, key_callback);
    //Emscripten, by default, captures all user events to the page.
    //This makes sense for a fullscreen game but not for out application

    SDL_SetHint(SDL_HINT_EMSCRIPTEN_KEYBOARD_ELEMENT, "#canvas");
    if (SDL_CreateWindowAndRenderer(w, h, SDL_WINDOW_RESIZABLE, &window, &renderer)) {
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Couldn't create window and renderer: %s", SDL_GetError());

    }

  struct sdl_context ctx;
//  ctx.renderer = renderer;
  funk_copy_node( &g_sdl_user_global_state, user_data);


  #if FUNK_BUILD_FOR_WEB

    // This is for when you want to use emscripten to
    // compile into webassembly and run in the browser
    int simulate_infinite_loop = 1; // call the function repeatedly
    int fps = 1; // call refresh every second, otherwise the browser wants to render at 60fps


    emscripten_set_main_loop_arg(sdl_render_loop, &ctx, fps, simulate_infinite_loop);


  #else
    // This is the path to run on your laptop
    SDL_Event event;
    while (1){
      sdl_render_loop((void*)&ctx);

      SDL_PollEvent(&event);
      if (event.type == SDL_QUIT) {
            break;
      }

    }
  #endif
  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);
  SDL_Quit();

}
