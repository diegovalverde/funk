
#ifndef FUNK_C_MODEL_H_INCLUDED
#define FUNK_C_MODEL_H_INCLUDED

//#define FUNK_DEBUG_BUILD 0

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>

enum funk_types{
type_invalid = 0,
type_int = 1,
type_double = 2,
type_array = 3,
type_empty_array = 4,
type_scalar = 5,
type_function = 6,
max_types = 7
};

char funk_types_str[][100]=
{
  "type_invalid",
  "type_int",
  "type_double",
  "type_array",
  "type_empty_array",
  "type_scalar",
  "type_function"
};

enum FUNK_CONFIG_PARAMS{
  FUNK_PARAM_DEBUG_VERBOSITY,
  FUNK_PARAM_PRINT_ARRAY_MAX_ELEMENTS

};

uint32_t g_funk_print_array_max_elements = 30;
uint32_t g_funk_print_array_element_per_row = 50;
uint32_t g_debug_continue = 0;
uint32_t g_funk_verbosity = 0;



#define FUNK_MAX_POOL_SIZE (50*50*100)
struct tnode;



struct tdata
{

  unsigned char type;
  union data_type{
    double f;
    int32_t i;
  } data;

};

struct tpool
{
  struct tdata data[FUNK_MAX_POOL_SIZE];
  uint32_t tail;
  uint32_t wrap_count;
} funk_global_memory_pool, funk_functions_memory_pool;

#define FUNK_MAX_DIMENSIONS 2 //may optimize when creating the runtime
struct tdimensions
{
  uint32_t count;  //stores 3,4,5...
  uint32_t d[FUNK_MAX_DIMENSIONS];
};

struct tnode
{
  uint32_t start, len;
  uint32_t wrap_creation;
  struct tpool * pool;
  struct tdimensions  dimension; //stride shall be an array of MAX_DIMENSIONS?


};



void funk_create_int_scalar(struct tpool * , struct tnode * , int32_t );

#endif
