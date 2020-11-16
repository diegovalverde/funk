#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>


#define FUNK_DEBUG_BUILD 1

// when compiling an application using debug mode
// the compiler updates the  g_funk_debug_current_executed_line for
// every instruction executed, you can then use this set breakpoints
// using the interactive debugger
#ifdef FUNK_DEBUG_BUILD
uint32_t g_funk_debug_current_executed_line = 0;
uint32_t g_funk_internal_function_tracing_enabled = 0;
#endif
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
uint32_t g_funk_verbosity = 0;



#define FUNK_MAX_POOL_SIZE 1024
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
  struct tpool * pool;
  struct tdimensions  dimension; //stride shall be an array of MAX_DIMENSIONS?
};

struct tnode gRenderLoopState;

void funk_sleep(int aSeconds){
  static int first = 1;
  if (first){
    first = 0;
    return;
  }
  sleep(aSeconds);
}


void funk_print_node_info(struct tnode * n){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("START %s \n", __FUNCTION__);
  #endif
  printf("%s[%d :%d] %d-dimensional",((n->pool == &funk_global_memory_pool)?"gpool":"fpool"), n->start, n->len, n->dimension.count );

  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("END %s \n", __FUNCTION__);
  #endif
}


void funk_copy_node(struct tnode * dst, struct tnode * src){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("START %s \n", __FUNCTION__);
  #endif

  dst->start = src->start;
  dst->len = src->len;
  dst->dimension.count = src->dimension.count;
  for (int i = 0; i < FUNK_MAX_DIMENSIONS; i++){
    dst->dimension.d[i] = src->dimension.d[i];
  }
  dst->pool = src->pool;

  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("END %s \n", __FUNCTION__);
  #endif

}

void set_s2d_user_global_state(struct tnode * n){

  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("START %s \n", __FUNCTION__);
  #endif

  funk_print_node_info(n);

  funk_copy_node( &gRenderLoopState, n);

  funk_print_node_info(&gRenderLoopState);
  printf(">>>>\n");

  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("END %s \n", __FUNCTION__);
  #endif

}

struct tnode get_s2d_user_global_state(){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("START %s \n", __FUNCTION__);
  #endif

  funk_print_node_info(&gRenderLoopState);

  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("END %s \n", __FUNCTION__);
  #endif

  return gRenderLoopState;

}

void funk_set_config_param(int id, int value){
  printf("-I- Setting conf parameter %d to value %d\n", id, value);
  switch (id){
    case FUNK_PARAM_DEBUG_VERBOSITY:
      g_funk_verbosity = value;
      break;

    case FUNK_PARAM_PRINT_ARRAY_MAX_ELEMENTS:
      g_funk_print_array_max_elements = value;
      break;
    defaut:
      break;
  };

}

void funk_print_type(unsigned char type){
  if (type >= 0 && type < max_types){
      printf("%s", funk_types_str[type]);
  } else {
      printf("-E- %s Invalid type %d\n", __FUNCTION__, type);
  }

}

void funk_exit(){
  printf("-I- Exiting\n");
  exit(0);
}

void funk_init(void){
  #ifdef FUNK_DEBUG_BUILD
  printf("%s ", __FUNCTION__);
  #endif

  unsigned int seed = (unsigned int)time(NULL);
  srand(seed);
  funk_global_memory_pool.tail = 0;
  funk_functions_memory_pool.tail = 0;

  #ifdef FUNK_DEBUG_BUILD

    for (int i = 0; i < FUNK_MAX_POOL_SIZE; i++){
      funk_global_memory_pool.data[i].data.i = 0;
    }
    printf("===== FUNK Interactive debugger =====\n");
    printf("-I- Global pool size %d\n", FUNK_MAX_POOL_SIZE);
    printf("-I- init_random_seed: %d\n", seed);
    printf("Press any key to start\n");
    getchar();


  #endif

}

int is_list_consecutive_in_memory(struct tnode * list, int32_t size){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
    printf("%s ", __FUNCTION__);
  #endif

  if (size <= 1)
    return 1;

  int prev = list[0].start;

  for (int i = 1; i < size; i++){
    int current = list[i].start;

    if (prev + 1 != current)
      return 0;
  }
  return 0;
}

void funk_create_list_slide_2d_var(struct tnode * src, struct tnode * dst , struct tnode * node_i, struct tnode * node_j){

  if (node_i->pool->data[node_i->start].type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, node_i->pool->data[node_i->start].type );
  }

  if (node_j->pool->data[node_j->start].type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, node_j->pool->data[node_j->start].type );
  }

  int32_t idx_0 = node_i->pool->data[node_i->start].data.i;
  int32_t idx_1 = node_j->pool->data[node_j->start].data.i;


  // negative indexes allow getting last elemets like in python
  idx_0 = (idx_0 < 0) ? src->dimension.d[0] - idx_0 : idx_0;
  idx_1 = (idx_1 < 0) ? src->dimension.d[1] - idx_1 : idx_1;


  if (idx_0 >= src->dimension.d[0]){
    printf("-E- %s index %d out of array boundary %d\n",__FUNCTION__, idx_0, src->dimension.d[0]);
  }

  if (idx_1  >= src->dimension.d[1]){
    printf("-E- %s index %d out of array boundary %d\n",__FUNCTION__, idx_1, src->dimension.d[1]);
  }

  dst->pool = src->pool;
  dst->dimension.count = 0;
  dst->len = 1;
  dst->start = src->start + src->dimension.d[1]* idx_0 + idx_1;


}

void funk_create_list_slide_1d_var(struct tnode * src, struct tnode * dst , struct tnode * node_i){
  if (node_i->pool->data[node_i->start].type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, node_i->pool->data[node_i->start].type );
  }

  int32_t idx_0 = node_i->pool->data[node_i->start].data.i;

  // negative indexes allow getting last elemets like in python
  idx_0 = (idx_0 < 0) ? dst->dimension.d[0] - idx_0 : idx_0;


  if (idx_0 >= src->dimension.d[0]){
    printf("-E- %s index %d out of array boundary %d\n",__FUNCTION__, idx_0, src->dimension.d[0]);
  }

  dst->pool = src->pool;
  dst->dimension.count = 0;
  dst->len = 1;
  dst->start = src->start + src->dimension.d[0]* idx_0;

}

void funk_create_list_slide(struct tnode * src, struct tnode * dst , int32_t * idx, int32_t idx_cnt){


  if (idx_cnt != dst->dimension.count){
    printf("-E- %s the number of indexes provided %d does not match dimension count %d\n",
      __FUNCTION__, idx_cnt, dst->dimension.count );
  }

  for (int i = 0; i < idx_cnt; i++){
    if (idx[i] >= dst->dimension.d[i]){
      printf("-E- %s the index %d >  upper bound %d for dimension %d\n",
        __FUNCTION__, idx[i], dst->dimension.d[i], i );
    }
  }

  dst->pool = src->pool;
  dst->dimension.count = 0;
  dst->len = 1;
  if (idx_cnt == 1){
    dst->start = src->start + idx[0];
  } else if (idx_cnt == 2){
    dst->start = src->start + dst->dimension.d[1]* idx[0] + idx[1];
  } else {
    printf("-E- %s %d dimensions are not yet supported\n", __FUNCTION__, idx_cnt );
  }

  if (dst->start >= src->len){
    printf("-E- %s index %d out of range for len %d\n", __FUNCTION__, dst->start, src->len );
  }

}

void funk_create_list(struct tpool * pool, struct tnode * n, struct tnode * list , int32_t size ){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
    printf("%s ", __FUNCTION__);
  #endif

  n->pool = pool;
  n->dimension.count = 1;



  if (is_list_consecutive_in_memory(list, size) == 1){
    n->start = list[0].start;
    n->len = size;

  } else {

    n->start  = pool->tail;
    n->len = size;
    pool->tail = (pool->tail + size) % FUNK_MAX_POOL_SIZE;

    for (int i = 0; i < size; i++){
      pool->data[n->start + i] = list[i].pool->data[list[i].start];
    }
  }

}

void funk_create_2d_matrix(struct tpool * pool, struct tnode * node, struct tnode * list, int32_t n, int32_t m ){
  #ifdef FUNK_DEBUG_BUILD
  if(g_funk_internal_function_tracing_enabled)
    printf("%s ", __FUNCTION__);
  #endif

  funk_create_list(pool, node, list, n*m );
  node->dimension.count = 2;
  node->dimension.d[0] = n;
  node->dimension.d[1] = m;
  printf(">>>>> %d %d pool_tail: %d\n", node->start, node->len, pool->tail );

}

void funk_create_scalar(struct tpool * pool, struct tnode * n, void * val, int32_t type){


  n->start  = pool->tail;
  n->len = 1;
  n->pool = pool;
  n->dimension.count = 1;

  pool->tail = (pool->tail + 1) % FUNK_MAX_POOL_SIZE;

  pool->data[n->start].type = type;

  switch (type) {
    case type_int:
    pool->data[n->start].data.i = *(int*)val;
    break;

    case type_double:
    pool->data[n->start].data.f = *(double*)val;
    break;
  }

}

void funk_create_int_scalar(struct tpool * pool, struct tnode * n, int32_t val){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
    printf("%s %s[%d] = %d\n", __FUNCTION__, ((pool == &funk_global_memory_pool)?"gpool":"fpool"),
    pool->tail, val);
  #endif

  funk_create_scalar(pool, n, (void*)&val, type_int);
}

void funk_create_float_scalar(struct tpool * pool, struct tnode * n, double val){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
    printf("%s %s[%d] = %f\n", __FUNCTION__, ((pool == &funk_global_memory_pool)?"gpool":"fpool"),
    pool->tail, val);
  #endif

  funk_create_scalar(pool, n, (void*)&val, type_double);
}

void funk_create_list_int_literal(struct tpool * pool, struct tnode * n, int32_t * list , int32_t size ){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s ", __FUNCTION__);
  #endif

  n->start  = pool->tail;
  n->len = size;
  n->pool = pool;
  n->dimension.count = 1;

  pool->tail = (pool->tail + size) % FUNK_MAX_POOL_SIZE;

  for (int i = 0; i < size; i++){
    pool->data[n->start + i].type = type_int;
    pool->data[n->start + i].data.i = list[i];
  }

}

void funk_create_2d_matrix_int_literal(struct tpool * pool, struct tnode * node, int32_t * list , int32_t n, int32_t m ){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s ", __FUNCTION__);
  #endif
  // Internally matrices are representes as contiguos
  // arrays in memory
  funk_create_list_int_literal(pool, node, list, n*m );
  node->dimension.count = 2;
  node->dimension.d[0] = n;
  node->dimension.d[1] = m;
  printf(">>>>> %d %d pool_tail: %d\n", node->start, node->len, pool->tail );

}

void funk_copy_element_from_pool(struct tpool * pool, struct tnode * dst, struct tnode * src, int32_t i, int32_t j){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s ", __FUNCTION__);
  #endif

  int32_t offset = (src->dimension.d[0] * i) + j;

  if (offset >= src->len){
      printf("-E- Indexes %d, %d are out of bounds\n", i, j);
  } else {
      dst->start = src->start + offset;
      dst->len = 1;
  }

}

void funk_print_scalar_element(struct tdata n){

    switch( n.type ){
      case type_int:
        printf(" %5d ", n.data.i);
        break;
      case type_double:
        printf(" %5.5f ", n.data.f);
        break;
      case type_empty_array:
        printf(" %5s ", "[]");
        break;
      default:
        printf(" %5s ","?");
    }
}

void funk_get_node_type(struct tnode  * node, uint32_t offset, unsigned char * type){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s %s[%d]", __FUNCTION__, ((node->pool == &funk_global_memory_pool)?"gpool":"fpool"), node->start+offset);
  #endif

  if (node->len > 0 && offset >= node->len){
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, node->len);
  }
  *type = node->pool->data[node->start + offset].type;

  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled){
    funk_print_type(*type);
    printf("\n ");
  }
  #endif
}

void funk_set_node_type(struct tnode  * node, uint32_t offset, unsigned char type){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s ", __FUNCTION__);
  #endif

  if (offset >= node->len){
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, node->len);
  }
  node->pool->data[node->start + offset].type =  type;
}

void funk_set_node_value_int(struct tnode  * node, uint32_t offset, uint32_t value){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s ", __FUNCTION__);
  #endif

  if (offset >= node->len){
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, node->len);
  }
  node->pool->data[node->start + offset].type = (unsigned char)type_int;
  node->pool->data[node->start + offset].data.i = value;
}

int32_t funk_get_node_value_int(struct tnode * node, int32_t offset){
    if (offset > node->len){
      printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, node->len);
    }
    return node->pool->data[node->start + offset].data.i;
}

void funk_print_pool(struct tpool * pool){

   for (int i = 0; i < 32; i++){

     funk_print_scalar_element(pool->data[i]);
     if (i >0 && (i + 1) % 7 == 0)
       printf("\n" );
   }
   printf("\n" );
 }

void funk_get_next_node(struct tnode *dst, struct tnode * n){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s %s start: %d len: %d\n", __FUNCTION__, ((n->pool == &funk_global_memory_pool)? "gpool":"fpool"), n->start, n->len);
  #endif
   dst->pool = n->pool;
   dst->dimension.count = n->dimension.count;
   for (int i =0; i < FUNK_MAX_DIMENSIONS; i++){
     dst->dimension.d[i] = n->dimension.d[i];
   }

   if (n->len == 0){
     dst->start = n->start;
     dst->len = 1;
     dst->pool->data[dst->start].type = type_empty_array;
     dst->pool->data[dst->start].data.i = 0;
   } else {
     dst->len = n->len - 1;
     dst->start = n->start+1;
   }

 }

void funk_debug_function_entry_hook(const char * function_name){

  #ifdef FUNK_DEBUG_BUILD

  char str[8];
  static int run_until_the_end = 0;

  if (run_until_the_end == 1)
    return;

  printf("\n\n\n=== %s === \n", function_name);
  do {
      printf(">");
      fgets(str,8,stdin);

      if (!strncmp(str,"gpool",5)){
        funk_print_pool(&funk_global_memory_pool);
      } else if (!strncmp(str,"fpool",5)){
        funk_print_pool(&funk_functions_memory_pool);
      } else if (!strncmp(str,"nostop",6)){
        run_until_the_end = 1;
      } else if (!strncmp(str,"q",1)){
        exit(0);
      }

  } while (strncmp(str,"c",1));




  #endif
}


void foo(void){
  struct tnode node;
  unsigned char type;

funk_get_node_type(&node, 0, &type);
int t = (int32_t)type;

}

void funk_memcp_arr(struct tnode * dst, struct tnode * src, int n, unsigned char dst_on_stack){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("START %s \n", __FUNCTION__);
  #endif

  for (int i = 0; i < n; ++i){
     funk_copy_node(&dst[i], &src[i]);


  }

  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("END %s \n", __FUNCTION__);
  #endif

}

void debug_print_arith_operation( struct tnode * node_r, int32_t r_offset,
                 struct tnode * node_a, int32_t a_offset,
                 struct tnode * node_b, int32_t b_offset){

  printf("%s[%d]",((node_a->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_a->start + a_offset );
  funk_print_scalar_element(node_a->pool->data[node_a->start + a_offset]);
  printf(" , ");
  printf("%s[%d]",((node_b->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_b->start + b_offset );
  funk_print_scalar_element(node_b->pool->data[node_b->start + b_offset]);

  printf(" = %s[%d]",((node_r->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_r->start + r_offset );
  funk_print_scalar_element(node_r->pool->data[node_r->start + r_offset]);
  printf(" )\n");
}

void funk_add_ri(struct tnode * node_r, int32_t r_offset,
                 struct tnode * node_a, int32_t a_offset,
                 int32_t lit)
  {
    #ifdef FUNK_DEBUG_BUILD
    if (g_funk_internal_function_tracing_enabled)
        printf("%s ", __FUNCTION__);
    #endif

    if (a_offset > node_a->len){
      printf("-E- Invalid index %d is greater than array size of %d", a_offset, node_a->len );
    }


    if (r_offset > node_r->len){
      printf("-E- Invalid index %d is greater than array size of %d", r_offset, node_r->len );
    }

  struct tdata a = node_a->pool->data[node_a->start + a_offset];
  struct tdata * r = &(node_r->pool->data[node_r->start + r_offset]);

  unsigned char t1 = a.type;


  if (t1 == type_int ){
      r->data.i = a.data.i + lit;
      r->type = type_int;

  }else if (t1 == type_double ){
      r->data.f = a.data.f +  ((double)lit);
      r->type = type_double;

  } else {
    //Invalid data
    printf("-E- funk_mul_rr: invalid types:\n ");

    r->type = type_invalid;
  }
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
  {
      printf("%s[%d]",((node_a->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_a->start + a_offset );
      funk_print_scalar_element(a);
      printf(" , ");
      printf("lit(%d)",lit);

      printf(" = %s[%d]",((node_r->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_r->start + r_offset );
      funk_print_scalar_element(*r);
      printf(" )\n");
  }
  #endif
}

void funk_mul(void *x, void *a, void *b, int type){
  if (type == 1){
    *((double *)x) = (double)(*(double*)a) * (double)(*(double*)b);
  } else {
    *((int *)x) = (int)(*(int*)a) * (int)(*(int*)b);
  }
}

void funk_div(void *x, void *a, void *b, int type){
  if (type == 1){
    *((double *)x) = (double)(*(double*)a) / (double)(*(double*)b);
  } else {
    *((int *)x) = (int)(*(int*)a) / (int)(*(int*)b);
  }
}

void funk_add(void *x, void *a, void *b, int type){
  if (type == 1){
    *((double *)x) = (double)(*(double*)a) + (double)(*(double*)b);
  } else {
    *((int *)x) = (int)(*(int*)a) + (int)(*(int*)b);
  }
}

void funk_sub(void *x, void *a, void *b, int type){
  if (type == 1){
    *((double *)x) = (double)(*(double*)a) - (double)(*(double*)b);
  } else {
    *((int *)x) = (int)(*(int*)a) - (int)(*(int*)b);
  }
}

void funk_mod(void *x, void *a, void *b, int type){
    *((int *)x) = (int)(*(int*)a) % (int)(*(int*)b);

}

void funk_slt(void *x, void *a, void *b, int type){

  if (type == 1){
    *((double *)x) = ((double)(*(double*)a) < (double)(*(double*)b)) ? 1 :0 ;
  } else {
    *((int *)x) = ((int)(*(int*)a) < (int)(*(int*)b)) ? 1 : 0;
  }

}

void funk_sgt(void *x, void *a, void *b, int type){

  if (type == 1){
    *((double *)x) = ((double)(*(double*)a) > (double)(*(double*)b)) ? 1 :0 ;
  } else {
    *((int *)x) = ((int)(*(int*)a) > (int)(*(int*)b)) ? 1 : 0;
  }

}

void funk_sge(void *x, void *a, void *b, int type){

  if (type == 1){
    *((double *)x) = ((double)(*(double*)a) >= (double)(*(double*)b)) ? 1 :0 ;
  } else {
    *((int *)x) = ((int)(*(int*)a) >= (int)(*(int*)b)) ? 1 : 0;
  }

}


void funk_eq(void *x, void *a, void *b, int type){

  if (type == 1){
    *((double *)x) = ((double)(*(double*)a) == (double)(*(double*)b)) ? 1 :0 ;
  } else {
    *((int *)x) = ((int)(*(int*)a) == (int)(*(int*)b)) ? 1 : 0;
  }
}

void funk_ne(void *x, void *a, void *b, int type){

  if (type == 1){
    *((double *)x) = ((double)(*(double*)a) != (double)(*(double*)b)) ? 1 :0 ;
  } else {
    *((int *)x) = ((int)(*(int*)a) != (int)(*(int*)b)) ? 1 : 0;
  }
}

void funk_or(void *x, void *a, void *b, int type){

  if (type == 1){
    *((double *)x) = ((double)(*(double*)a) != 0.0 || (double)(*(double*)b) != 0.0) ? 1 :0 ;
  } else {
    *((int *)x) = ((int)(*(int*)a) != 0 ||  (int)(*(int*)b) != 0) ? 1 : 0;
  }

}



void funk_arith_op_rr(struct tnode * node_r, int32_t r_offset,
                 struct tnode * node_a, int32_t a_offset,
                 struct tnode * node_b, int32_t b_offset,
                 void (*f)(void *, void *, void *, int ))
  {


    if (a_offset > node_a->len){
      printf("-E- Invalid index %d is greater than array size of %d", a_offset, node_a->len );
    }

    if (b_offset > node_b->len){
      printf("-E- Invalid index %d is greater than array size of %d", b_offset, node_b->len );
    }

    if (r_offset > node_r->len){
      printf("-E- Invalid index %d is greater than array size of %d", r_offset, node_r->len );
    }

  struct tdata a = node_a->pool->data[node_a->start + a_offset];
  struct tdata b = node_b->pool->data[node_b->start + b_offset];
  struct tdata * r = &(node_r->pool->data[node_r->start + r_offset]);

  unsigned char t1 = a.type;
  unsigned char t2 = b.type;

  if (t2 == type_empty_array) t2 = type_int;

  if (t1 == type_empty_array) t1 = type_int;

  if (t1 == type_int && t2 == type_int){
      f((void*)&r->data.i, (void*)&a.data.i, (void*)&b.data.i, 0);
      r->type = type_int;

  }else if (t1 == type_double && t2 == type_double){
      f((void*)&r->data.f, (void*)&a.data.f, (void*)&b.data.f, 1);
      r->type = type_double;

  } else if (t1 == type_double && t2 == type_int){
      f((void*)&r->data.f, (void*)&a.data.f, (void*)&b.data.i, 1);
      r->type = type_double;

  } else if (t1 == type_int && t2 == type_double){
      f((void*)&r->data.f, (void*)&a.data.i, (void*)&b.data.f, 1);
      r->type = type_double;

  } else {
    printf("-E- %s: invalid types: ", __FUNCTION__);

    funk_print_type(t1);
    printf(" , ");
    funk_print_type(t2);
    printf("\n");

    r->type = type_invalid;
  }

  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      debug_print_arith_operation(node_r, r_offset, node_a, a_offset, node_b, b_offset);
  #endif

}

void funk_mul_rr(struct tnode * node_r, int32_t r_offset,
                 struct tnode * node_a, int32_t a_offset,
                 struct tnode * node_b, int32_t b_offset){


                   funk_arith_op_rr(node_r, r_offset,
                                    node_a, a_offset,
                                    node_b, b_offset, funk_mul);
                 }

void funk_add_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){


                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_add);
                }

void funk_sub_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){


                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_sub);
                }

void funk_div_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){


                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_div);
                }

void funk_mod_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){


                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_mod);
                }

void funk_or_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){


                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_or);
                }

void funk_ne_rr(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                struct tnode * node_b, int32_t b_offset){


                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   node_b, b_offset, funk_ne);
                }

void funk_add_rf(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                double value){

                  struct tnode node_b;
                  //TODO: maybe create a smaller pool for this?
                  funk_create_float_scalar(&funk_functions_memory_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_add);
                }

void funk_sub_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                  struct tnode node_b;

                  funk_create_int_scalar(&funk_functions_memory_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_sub);
                }

void funk_div_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                  struct tnode node_b;

                  funk_create_int_scalar(&funk_functions_memory_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_div);
                }

void funk_sub_rf(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                double value){

                  struct tnode node_b;

                  funk_create_float_scalar(&funk_functions_memory_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_sub);
                }

void funk_slt_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                struct tnode node_b;
                funk_create_int_scalar(&funk_functions_memory_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_slt);

}

void funk_sgt_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                struct tnode node_b;
                funk_create_int_scalar(&funk_functions_memory_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_sgt);

}
void funk_sge_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                struct tnode node_b;
                funk_create_int_scalar(&funk_functions_memory_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_sge);

}


void funk_eq_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                struct tnode node_b;
                funk_create_int_scalar(&funk_functions_memory_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_eq);

}

void funk_print_dimension(struct tnode * n){
  printf("( ");
  for (int i = 0; i < n->dimension.count; i++){
    printf("%d ", n->dimension.d[i]);
  }
  printf(")");
}

void print_scalar(struct tnode * n){

#ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
  {
    printf("%s\n", __FUNCTION__ );
    funk_print_node_info(n);
  }
#endif

  if (n->dimension.count == 0){

    funk_print_scalar_element(n->pool->data[n->start]);

  } else if (n->dimension.count == 1){


    for (int i = n->start; i < (n->start + n->len); i++){
      funk_print_scalar_element(n->pool->data[i]);
    }


  } else if (n->dimension.count == 2){
    printf("\n");
    for (int i = 0; i < n->dimension.d[0]; i++){
      for (int j = 0; j < n->dimension.d[1]; j++){
          funk_print_scalar_element(n->pool->data[n->start + (i * n->dimension.d[1]) + j]);
      }
      printf("\n");
    }
  } else {
    printf(" [...] %d-dimensional with %d elements\n", n->dimension.count, n->len);
  }

}

void print_2d_array(struct tnode * n, uint32_t i, uint32_t j){
  funk_print_scalar_element(n->pool->data[n->start + n->dimension.d[1]*i + j ]);
}
#if 0
struct tnode * funk_concatenate_lists(struct tnode * left, struct tnode * right){
  int i = 0;
  struct tnode * p = left;
  while(p && p->next->type != type_empty_array)
  {

    p = p->next;
    i++;
  }

  //make sure the dummy node will get deleted eventually
  p->next->refCount = 0;


  p->next = right;
  print_scalar(left);

  return left;

}

double rand_double(double lower, double upper){

  return (((double)rand()/(double)(RAND_MAX)) * (upper-lower)) + lower;


}

struct gcNode {
  struct tnode * ptr;
  struct gcNode * next;
};

struct GC {
  struct gcNode * head;
  struct gcNode * tail;
} gCollector;

void initGarbageCollector( void ){
  gCollector.head = (struct gcNode*)malloc(sizeof(struct gcNode));
  gCollector.head->ptr = NULL;
  gCollector.head->next = NULL;
  gCollector.tail = gCollector.head;
};

 void collectGarbage( void ){


  struct gcNode * prev = gCollector.head;
  struct gcNode * p = gCollector.head->next;

  while (p && p->next){
    if (p->ptr && p->ptr->refCount <= 0){
      free(p->ptr);
      prev->next = p->next;
      free(p);
      p = prev->next;
    } else {
      prev = p;
      p = p->next;
    }
  }
}

void printCollectorStatus(){
  printf("===== garbage collector =====\n");

  struct gcNode * prev = gCollector.head;
  struct gcNode * p = gCollector.head->next;
  int i = 0;
  while (p && p->next){
    if (p->ptr){
      printf("%d: addr: %p ref_cnt: %d val:", i, p->ptr, p->ptr->refCount);
      switch (p->ptr->pd.type) {
        case type_double:
          printf("<double> %f\n", p->ptr->pd.data.f);
          break;
        case type_int:
          printf("<int> %d\n", p->ptr->pd.data.i);
          break;
        case type_invalid:
          printf("<invalid_data_type>\n");
          break;
        default:
          printf("<unknown type>\n");
          break;
      }

    } else {
      printf("null\n");
    }
    i++;
    p = p->next;
  }

}



 void createLhsStackVar(struct tnode * p){
  p->next = NULL;
  p->refCount = 0;
}

 void markNodeForGarbageCollection(struct tnode * p){
  while (p){

    p->refCount = 0;
    p = p->next;
  }
}

void registerHeapAllocation(struct tnode * n){

  n->refCount = 1;

  gCollector.tail->next = (struct gcNode*)malloc(sizeof(struct gcNode));
  gCollector.tail = gCollector.tail->next;
  gCollector.tail->next = NULL;
  gCollector.tail->ptr = n;


}


struct tnode * funk_mallocNodeRight(struct tnode * head){

  struct tnode* p_right = (struct tnode*)malloc(sizeof(struct tnode));
  p_right->next = NULL;

  head->next = p_right;
  head->type = type_array;
  p_right->pd.type = head->pd.type;
  p_right->pd.data.i = -1;
  p_right->type = type_array;

  return p_right;
}

struct tnode funk_listFillerIota(int i){
  struct tnode node;
  node.pd.type = type_int;
  node.pd.data.i = i;
  return node;
}

struct tnode * funk_CreateLinkedListConstInt(int start, int end, int val ){
   struct tnode * head = NULL;
   struct tnode * prev = NULL;
   struct tnode * node = NULL;

  int i = 0;
  for (i = start; i <= end; ++i){
    node = (struct tnode*)malloc(sizeof(struct tnode));
    node->type = type_array; //List Node
    node->pd.type = type_int;
    node->pd.data.i = val;
    registerHeapAllocation(node);

    if (prev){
        prev->next = node;
    } else {
      head = node;
    }
    prev = node;
  }

   struct tnode * tail = (struct tnode*)malloc(sizeof(struct tnode));
   tail->type = type_empty_array;
   tail->pd.type = type_empty_array;

   if (node != NULL)
      node->next = tail;

   if (head == NULL)
      head = tail;

   tail->next = NULL;
   tail->pd.data.i = i;
   return head;
}

#endif

float funk_ToFloat(struct tnode * n){
  if (n->pool->data[n->start].type == type_int){
    return (float)n->pool->data[n->start].data.i;
  } else if (n->pool->data[n->start].type == type_double){
    return (float)n->pool->data[n->start].data.f;
  } else {
    n->pool->data[n->start].type = type_invalid;
    return 0.0f;
  }
}


/*
Input: ASCII a file with numbers separated by spaces
Output: List of numbers
*/
  void funk_read_list_from_file(struct tpool * pool, struct tnode * dst, char * path ){


  FILE *fp;
  fp = fopen(path, "rt");

  if (fp == NULL)
  {
    printf("-E- File '%s' cannot be read\n", path);
    exit(1);
  }

  if (g_funk_verbosity > 0){
    printf("-D- Opened file '%s'",path);
  }

  int value = 0;
  int count = 0;
  dst->start = pool->tail;
  dst->dimension.count = 1;
  dst->pool = pool;

  while(fscanf(fp,"%d",&value) == 1)
  {
    pool->data[pool->tail].data.i = value;
    pool->data[pool->tail].type = type_int;
    pool->tail = (pool->tail + 1 )%FUNK_MAX_POOL_SIZE;
    count++;
  }

  dst->len = count;

  fclose(fp);


}

void reshape(struct tnode * dst, int * idx, int count){
  dst->dimension.count = count;
  int number_of_elements = 1;
  for (int i = 0;  (i < count && i < FUNK_MAX_DIMENSIONS); i++){
    dst->dimension.d[i] = idx[i];
    number_of_elements *= dst->dimension.d[i];
  }

  printf("%d:[%d x %d]\n", dst->dimension.count, dst->dimension.d[0],dst->dimension.d[1]);

  if (number_of_elements > dst->len){
    printf("-E- reshape operation not possible for variable with %d elements\n", dst->len);
  }
}
