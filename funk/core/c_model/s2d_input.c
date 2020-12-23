
#include <simple2d.h>
#include "funk_c_model.h"

void s2d_onkey(struct tnode*, int32_t ,struct tnode*);

void funk_s2d_on_key_callback(S2D_Event e){
  if (e.type != S2D_KEY_DOWN)
    return;

    struct tnode s2d_key_pressed_code;
    funk_create_int_scalar(function_pool, &s2d_key_pressed_code, (int)e.key );
    struct tnode result;
    funk_create_int_scalar(function_pool, &result, -1 );
    s2d_onkey(&result,1,&s2d_key_pressed_code);

}

/*
  When the compiler detects that the 's2_onkyey' function was defined by the
  user then it will call this function in order to register the callback above
*/
void funk_s2d_register_input_callback(S2D_Window * window ){
  window->on_key = funk_s2d_on_key_callback;
}
