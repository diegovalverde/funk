#include <SDL2/SDL.h>
#if FUNK_BUILD_FOR_WEB
#include <emscripten.h>
#endif
//#include <cstdlib>
#include "funk_sdl.h"
SDL_Renderer *renderer = NULL;


struct tnode g_sdl_user_global_state;

void sdl_render(struct tnode *, int32_t, struct tnode *);
void funk_create_int_scalar(enum pool_types , struct tnode * , int32_t );
//void funk_print_scalar_element(struct tdata n);

void set_sdl_user_global_state(struct tnode * state)
{

  funk_copy_node( &g_sdl_user_global_state, state);

}


void sdl_render_loop(void *arg)
{



    //struct sdl_context ctx;// = (struct sdl_context * )arg;
    //funk_copy_node(&ctx.user_data, &g_sdl_user_global_state);
    //SDL_Renderer *renderer = ctx->renderer;

    // example: draw a moving rectangle

    // red background
    SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
    SDL_RenderClear(renderer);
/*
    // moving blue rectangle
    SDL_Rect r;
    r.x = 50;
    r.y = 50;
    r.w = 50;
    r.h = 50;
    SDL_SetRenderDrawColor(renderer, 0, 0, 255, 255 );
    SDL_RenderFillRect(renderer, &r );
*/
    struct tnode result;
    funk_create_int_scalar(function_pool, &result, 0);

    sdl_render(&result, 1, &g_sdl_user_global_state);
    SDL_RenderPresent(renderer);

}



void funk_sdl_create_window(int32_t w, int32_t h, struct tnode * user_data)
{
    printf("-I- Initializing SDL 2D\n");

    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Couldn't initialize SDL: %s", SDL_GetError());
    }
    SDL_Window *window;
    //SDL_Renderer *renderer;

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
    int fps = -1; // call the function as fast as the browser wants to render (typically 60fps)
    emscripten_set_main_loop_arg(sdl_render_loop, &ctx, fps, simulate_infinite_loop);
  #else
    // This is the path to run on your laptop
    SDL_Event event;
    while (1){
      SDL_PollEvent(&event);
      if (event.type == SDL_QUIT) {
            break;
      }
      sdl_render_loop((void*)&ctx);
    }
  #endif
  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);
  SDL_Quit();

}
