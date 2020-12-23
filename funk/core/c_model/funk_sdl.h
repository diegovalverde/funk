#ifndef FUNK_SDL_H_INCLUDED
#define FUNK_SDL_H_INCLUDED
#include "funk_c_model.h"

struct sdl_context
{
    SDL_Renderer *renderer;
    struct tnode user_data;
    
};

#endif
