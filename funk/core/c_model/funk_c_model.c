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


/*
void funk_debug_printNode(struct tnode * node ){

  struct tpool * pool = node->pool;
  printf("pool %p %%d:%%d [ ", pool, node->start, node->end);
  for (int i = node->start; i < node->end; i++)
  {

      int type = pool->data[i].type;

      switch(type){

        case type_int:
          printf("int64: %%d", pool->data[i].data.i);
          break;

        case type_double:
          printf("double: %f",pool->data[i].data.f);
          break;


        case type_invalid:
        case type_empty_array:
        case type_array:
        default:
          printf("n/a");
          break;

      }
      printf(" ");
  }
  printf("]\n");

}
*/
/*
struct tnode gRenderLoopState;

void funk_sleep(int aSeconds){
  static int first = 1;
  if (first){
    first = 0;
    return;
  }
  sleep(aSeconds);
}


void set_s2d_user_global_state(struct tnode * n){

  funk_deep_copy_node(&gRenderLoopState,n);
  if (g_funk_verbosity){
    printf("get_s2d_user_global_state\n");
    funk_debug_printNode(&gRenderLoopState);
  }
}

struct tnode get_s2d_user_global_state(){
  if (g_funk_verbosity){
    printf("get_s2d_user_global_state\n");
    funk_debug_printNode(&gRenderLoopState);
  }
  return gRenderLoopState;
}
*/

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

#if 0
void funk_slt_ri(struct tnode * r, struct tnode * n1, int lit){
  if (n1->pd.type == type_int){
      r->pd.data.i = (n1->pd.data.i < lit) ? 1 : 0;
      r->pd.type = type_int;
  } else if (n1->pd.type == type_double ){
    r->pd.data.i = (((int)n1->pd.data.f) < lit) ? 1 : 0;;
    r->pd.type = type_int;
  } else {
    //Invalid data
    r->pd.type = type_invalid;
  }

  }


  void funk_sgt_ri(struct tnode * r, struct tnode * n1, int lit){
    if (n1->pd.type == type_int){
        r->pd.data.i = (n1->pd.data.i > lit) ? 1 : 0;
        r->pd.type = type_int;
    } else if (n1->pd.type == type_double ){
      r->pd.data.i = (((int)n1->pd.data.f) > lit) ? 1 : 0;;
      r->pd.type = type_int;
    } else {
      //Invalid data
      r->pd.type = type_invalid;
    }

    }



      void funk_sge_ri(struct tnode * r, struct tnode * n1, int lit){
        if (n1->pd.type == type_int){
            r->pd.data.i = (n1->pd.data.i >= lit) ? 1 : 0;
            r->pd.type = type_int;
        } else if (n1->pd.type == type_double ){
          r->pd.data.i = (((int)n1->pd.data.f) >= lit) ? 1 : 0;;
          r->pd.type = type_int;
        } else {
          //Invalid data
          r->pd.type = type_invalid;
        }

        }

    void funk_sge_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
      if (n1->pd.type == type_int && n2->pd.type == type_int){
          r->pd.data.i = (n1->pd.data.i >= n2->pd.data.i) ? 1 : 0;
          r->pd.type = type_int;
      } else if (n1->pd.type == type_double && n2->pd.type == type_double){

        r->pd.data.i = (n1->pd.data.f >= n2->pd.data.f) ? 1 : 0;
        r->pd.type = type_int;
      } else {
        printf("funk_sge_rr: invalid types %d %d\n", n1->pd.type, n2->pd.type);
        r->pd.type = type_invalid;
      }

      }

void funk_flt_rf(struct tnode * r, struct tnode * n1, double lit){
  if (n1->pd.type == type_double){
      r->pd.data.i = (n1->pd.data.f < lit) ? 1 : 0;
      r->pd.type = type_int;
  } else if (n1->pd.type == type_int ){
    r->pd.data.f = (((double)n1->pd.data.i) < lit) ? 1 : 0;;
    r->pd.type = type_int;
  } else {
    //Invalid data
    r->pd.type = type_invalid;
  }

}

void funk_mod_ri(struct tnode * r, struct tnode * n1, int lit){
  if (n1->pd.type == type_double){
      r->pd.data.f = (int)(n1->pd.data.f) % lit;
      r->pd.type = type_int;
  } else if (n1->pd.type == type_int ){
    r->pd.data.i = n1->pd.data.i % lit;
    r->pd.type = type_int;
  } else {
    //Invalid data
    printf("funk_mod_ri: invalid types %d Int\n ", n1->pd.type);
    r->pd.type = type_invalid;
  }

}

void funk_eq_ri(struct tnode * r, struct tnode * n1, int lit){
  if (n1->pd.type == type_double){
    r->pd.data.i = (((int)n1->pd.data.f) == lit) ? 1 : 0;
    r->pd.type = type_int;
  } else if (n1->pd.type == type_int ){
    r->pd.data.i = (n1->pd.data.i == lit) ? 1 : 0;
    r->pd.type = type_int;
  } else {
    //Invalid data
    printf("funk_eq_ri: invalid types %d\n ", n1->pd.type);
    r->pd.type = type_invalid;
  }

}


void funk_eq_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
  if (n1->pd.type == type_double && n2->pd.type == type_double){
    r->pd.data.i = (n1->pd.data.f == n2->pd.data.f) ? 1 : 0;
    r->pd.type = type_int;
  } else if (n1->pd.type == type_int && n2->pd.type == type_int){
    r->pd.data.i = (n1->pd.data.i == n2->pd.data.i) ? 1 : 0;
    r->pd.type = type_int;
  } else {
    //Invalid data
    printf("funk_eq_rr: invalid types %d\n ", n1->pd.type);
    r->pd.type = type_invalid;
  }

}

void funk_or_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
  if (n1->pd.type == type_int && n2->pd.type == type_int){
      r->pd.data.i = ((n1->pd.data.i != 0) || (n2->pd.data.i != 0)) ? 1 : 0;
      r->pd.type = type_int;
  } else if (n1->pd.type == type_double && n2->pd.type == type_double){
    r->pd.data.f= ((n1->pd.data.f != 0.0f) || (n2->pd.data.f != 0.0f)) ? 1.0f : 0.0f;
    r->pd.type = type_double;
  } else if (n1->pd.type != n2->pd.type){

    printf("funk_or_rr: invalid types %d, %d\n ", n1->pd.type, n2->pd.type);
    r->pd.type = type_invalid;
  } else {
    r->pd.type = type_invalid;
  }
}


void funk_and_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){

  if (n1->pd.type == type_int && n2->pd.type == type_int){
      r->pd.data.i = ((n1->pd.data.i != 0) && (n2->pd.data.i != 0)) ? 1 : 0;
      r->pd.type = type_int;
  } else if (n1->pd.type == type_double && n2->pd.type == type_double){
    r->pd.data.f= ((n1->pd.data.f != 0.0f) && (n2->pd.data.f != 0.0f)) ? 1.0f : 0.0f;
    r->pd.type = type_double;
  } else if (n1->pd.type != n2->pd.type){
    printf("funk_and_rr: invalid types %d, %d\n ", n1->pd.type, n2->pd.type);
    r->pd.type = type_invalid;
  } else {
    r->pd.type = type_invalid;
  }
}
#endif

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

  printf("%s i=%d j=%d\n", __FUNCTION__, idx_0, idx_1);

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

void funk_create_int_scalar(struct tpool * pool, struct tnode * n, int32_t val){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
    printf("%s %s[%d] = %d\n", __FUNCTION__, ((pool == &funk_global_memory_pool)?"gpool":"fpool"),
    pool->tail, val);
  #endif

  n->start  = pool->tail;
  n->len = 1;
  n->pool = pool;
  n->dimension.count = 1;

  pool->tail = (pool->tail + 1) % FUNK_MAX_POOL_SIZE;

  pool->data[n->start].type = type_int;
  pool->data[n->start].data.i = val;


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


void foo(void){
  struct tnode node;


}

void funk_print_pool(struct tpool * pool){

   for (int i = 0; i < 64; i++){

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

void funk_debug_function_entry_hook(void){

  #ifdef FUNK_DEBUG_BUILD

  char str[8];
  static int run_until_the_end = 0;

  if (run_until_the_end == 1)
    return;

  printf("Stopped at the beginning of function\n");
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

void funk_memcp_arr(struct tnode * dst, struct tnode * src, int n, unsigned char dst_on_stack){
  for (int i = 0; i < n; ++i){
      dst[i] = src[i];

  }

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

void funk_add_rr(struct tnode * node_r, int32_t r_offset,
                 struct tnode * node_a, int32_t a_offset,
                 struct tnode * node_b, int32_t b_offset)
  {
    #ifdef FUNK_DEBUG_BUILD
    if (g_funk_internal_function_tracing_enabled)
      printf("%s ", __FUNCTION__);
    #endif

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

  if (t2 == type_empty_array)
    t2 = type_int;

    if (t1 == type_empty_array)
      t1 = type_int;

  if (t1 == type_int && t2 == type_int){
      r->data.i = a.data.i + b.data.i;
      r->type = type_int;

  }else if (t1 == type_double && t2 == type_double){
      r->data.f = a.data.f + b.data.f;
      r->type = type_double;

  } else if (t1 == type_double && t2 == type_int){
      r->data.f = a.data.f + (double)(b.data.i);
      r->type = type_double;

  } else if (t1 == type_int && t2 == type_double){
      r->data.f = (double)a.data.i + b.data.f;
      r->type = type_double;

  } else {
    //Invalid data
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
                 struct tnode * node_b, int32_t b_offset)
  {
    #ifdef FUNK_DEBUG_BUILD
    //printf("%s ", __FUNCTION__);
    #endif

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

  if (t1 == type_int && t2 == type_int){
      r->data.i = a.data.i * b.data.i;
      r->type = type_int;

  }else if (t1 == type_double && t2 == type_double){
      r->data.f = a.data.f * b.data.f;
      r->type = type_double;

  } else if (t1 == type_double && t2 == type_int){
      r->data.f = a.data.f * (double)(b.data.i);
      r->type = type_double;

  } else if (t1 == type_int && t2 == type_double){
      r->data.f = (double)a.data.i * b.data.f;
      r->type = type_double;

  } else {
    //Invalid data
    printf("-E- funk_mul_rr: invalid types:\n ");

    r->type = type_invalid;
  }

  #ifdef FUNK_DEBUG_BUILD
      //debug_print_arith_operation(node_r, r_offset, node_a, a_offset, node_b, b_offset);
  #endif

}
#if 0
void funk_div_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
  if (n1->pd.type == 2 && n2->pd.type == 2){
      r->pd.data.f = n1->pd.data.f / n2->pd.data.f;
      r->pd.type = 2;
  } else if (n1->pd.type == 1 && n2->pd.type == 1){
    r->pd.data.i = n1->pd.data.i / n2->pd.data.i;
    r->pd.type = 1;
  } else if (n1->pd.type == 2 && n2->pd.type == 1){
    r->pd.data.f = n1->pd.data.f / ((double)(n2->pd.data.i));
    r->pd.type = 2;
  } else if (n1->pd.type == 1 && n2->pd.type == 2){
    r->pd.data.f = ((double)n1->pd.data.i) / n2->pd.data.f;
    r->pd.type = 2;
  } else {
    //Invalid data
    printf("-E- funk_div_rr: invalid types %d, %d\n ", n1->pd.type, n2->pd.type);
    r->pd.type = type_invalid;
  }

}

void funk_add_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
  if (n1->pd.type == type_double && n2->pd.type == type_double){
      r->pd.data.f = n1->pd.data.f + n2->pd.data.f;
      r->pd.type = type_double;
  } else if (n1->pd.type == type_int && n2->pd.type == type_int){
    r->pd.data.i = n1->pd.data.i + n2->pd.data.i;
    r->pd.type = type_int;
  } else if (n1->pd.type == type_double && n2->pd.type == type_int){
    r->pd.data.f = n1->pd.data.f + ((double)(n2->pd.data.i));
    r->pd.type = type_double;
  } else if (n1->pd.type == type_int && n2->pd.type == type_double){
    r->pd.data.f = ((double)n1->pd.data.i) + n2->pd.data.f;
    r->pd.type = type_double;
  } else {
    //Invalid data

    printf("-E- funk_add_rr: invalid types %d, %d\n ", n1->pd.type, n2->pd.type);
    r->pd.type = type_invalid;
  }

}


void funk_sub_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
  if (n1->pd.type == type_double && n2->pd.type == type_double){
      r->pd.data.f = n1->pd.data.f - n2->pd.data.f;
      r->pd.type = type_double;
  } else if (n1->pd.type == type_int && n2->pd.type == type_int){
    r->pd.data.i = n1->pd.data.i - n2->pd.data.i;
    r->pd.type = type_int;
  } else if (n1->pd.type == type_double && n2->pd.type == type_int){
    r->pd.data.f = n1->pd.data.f - ((double)(n2->pd.data.i));
    r->pd.type = type_double;
  } else if (n1->pd.type == type_int && n2->pd.type == type_double){
    r->pd.data.f = ((double)n1->pd.data.i) - n2->pd.data.f;
    r->pd.type = type_double;
  } else {
    //Invalid data
    printf("-E- funk_sub_rr: invalid types %d, %d\n ", n1->pd.type, n2->pd.type);
    r->pd.type = type_invalid;
  }

}



void funk_add_rf(struct tnode * r, struct tnode * n1, double d){
  if (n1->pd.type == 2){
      r->pd.data.f = n1->pd.data.f + d;
      r->pd.type = 2;
  } else if (n1->pd.type == 1 ){
    r->pd.data.f = ((double)n1->pd.data.i) + d;
    r->pd.type = 2;
  } else {
    //Invalid data
    r->pd.type = 0;
  }

}



void funk_mul_ri(struct tnode * r, struct tnode * n1, int lit){
  if (n1->pd.type == type_int ){
      r->pd.data.i = n1->pd.data.i * lit;
      r->pd.type = type_int;
  } else if (n1->pd.type == type_double ){
    r->pd.data.f = n1->pd.data.f * ((double)lit);
    r->pd.type = type_double;
  } else {
    //Invalid data
    printf("-E- funk_mul_ri: invalid types %d\n ", n1->pd.type);
    r->pd.type = type_invalid;
  }

}


void funk_div_ri(struct tnode * r, struct tnode * n1, int lit){
  if (n1->pd.type == type_int ){
      r->pd.data.i = n1->pd.data.i / lit;
      r->pd.type = type_int;
  } else if (n1->pd.type == type_double ){
    r->pd.data.f = n1->pd.data.f / ((double)lit);
    r->pd.type = type_double;
  } else {
    //Invalid data
    printf("-E- funk_div_ri: invalid types %d\n ", n1->pd.type);
    r->pd.type = type_invalid;
  }

}


void funk_mul_rf(struct tnode * r, struct tnode * n1, double lit){
  if (n1->pd.type == type_int ){
      r->pd.data.f = ((double)n1->pd.data.i) * lit;
      r->pd.type = type_double;
  } else if (n1->pd.type == type_double ){
    r->pd.data.f = n1->pd.data.f * lit;
    r->pd.type = type_double;
  } else {
    //Invalid data
    printf("-E- funk_mul_rf: invalid types %d\n ", n1->pd.type);
    r->pd.type = type_invalid;
  }

}


void funk_add_ri(struct tnode * r, struct tnode * n1, int lit){
  if (n1->pd.type == type_int ){
      r->pd.data.i = n1->pd.data.i + lit;
      r->pd.type = type_int;
  } else if (n1->pd.type == type_double ){
    r->pd.data.f = n1->pd.data.f + ((double)lit);
    r->pd.type = type_double;
  } else {
    printf("-E- funk_add_ri: invalid types %d\n ", n1->pd.type);
    r->pd.type = type_invalid;
  }

}



void funk_sub_rf(struct tnode * r, struct tnode * n1, double d){
  if (n1->pd.type == type_double){
      r->pd.data.f = n1->pd.data.f - d;
      r->pd.type = type_double;
  } else if (n1->pd.type == type_int ){
    r->pd.data.f = ((double)n1->pd.data.i) - d;
    r->pd.type = type_double;
  } else {
    //Invalid data
    printf("-E- funk_sub_rf: invalid types %d\n ", n1->pd.type);
    r->pd.type = type_invalid;
  }

}


void funk_sub_ri(struct tnode * r, struct tnode * n1, int i){
  if (n1->pd.type == type_double){
      r->pd.data.f = n1->pd.data.f - ((double)i);
      r->pd.type = type_double;
  } else if (n1->pd.type == type_int ){
    r->pd.data.i = n1->pd.data.i - i;
    r->pd.type = type_int;
  } else {
    printf("-E- funk_sub_ri: invalid types %d\n ", n1->pd.type);
    r->pd.type = type_invalid;
  }

}


void funk_mod_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
  if (n1->pd.type == 2 && n2->pd.type == 2){
      r->pd.data.i = ((int)n1->pd.data.f) % ((int)n2->pd.data.f);
      r->pd.type = 1;
  } else if (n1->pd.type == 1 && n2->pd.type == 1){
    r->pd.data.i = n1->pd.data.i % n2->pd.data.i;
    r->pd.type = 1;
  } else if (n1->pd.type == 2 && n2->pd.type == 1){
    r->pd.data.i = ((int)(n1->pd.data.f)) % n2->pd.data.i;
    r->pd.type = 1;
  } else if (n1->pd.type == 1 && n2->pd.type == 2){
    r->pd.data.f = n1->pd.data.i % ((int)n2->pd.data.f);
    r->pd.type = 1;
  } else {
    printf("-E- funk_mod_rr: invalid types %d\n ", n1->pd.type);
    r->pd.type = type_invalid;
  }

}

int rand_range(int lower, int upper){

  return rand() % (upper - lower + 1) + lower;


}
#endif

void funk_print_dimension(struct tnode * n){
  printf("( ");
  for (int i = 0; i < n->dimension.count; i++){
    printf("%d ", n->dimension.d[i]);
  }
  printf(")");
}

void print_scalar(struct tnode * n){

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
    printf(" [...] \n");
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


void funk_exit(){
  collectGarbage();
  printf("-I- Exiting\n");
  exit(0);
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

struct tnode * createLinkedList(int start, int end, unsigned char type ){
   struct tnode * head = NULL;
   struct tnode * prev = NULL;
   struct tnode * node = NULL;

  int i = 0;
  for (i = start; i <= end; ++i){
    node = (struct tnode*)malloc(sizeof(struct tnode));
    node->type = type_array;
    node->pd.type = type;
    node->pd.data.i = i;
    registerHeapAllocation(node);

    if (prev){
        prev->next = node;
    } else {
      head = node;
    }
    prev = node;
  }

   struct tnode * tail = (struct tnode*)malloc(sizeof(struct tnode));
   tail->type = type_empty_array; //empty_array
   tail->pd.type = type;

   if (node != NULL)
      node->next = tail;

   if (head == NULL)
      head = tail;

   tail->next = NULL;
   tail->pd.data.i = i;
   return head;
}


float funk_ToFloat(struct tnode * n){
  if (n->pd.type == type_int){
    return (float)n->pd.data.i;
  } else if (n->pd.type == type_double){
    return (float)n->pd.data.f;
  } else {
    n->pd.type = type_invalid;
    return 0.0f;
  }
}

/*
Input: ASCII a file with numbers separated by spaces
Output: List of numbers
*/
struct tnode *  funk_read_list_from_file(char * path ){
  struct tnode * dst = (struct tnode *)malloc(sizeof(struct tnode));
  struct tnode * p = dst;

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
  while(fscanf(fp,"%d",&value) == 1)
  {
    p->type = type_array;
    p->pd.data.i = value;
    p->pd.type = type_int;
    p->next = (struct tnode *)malloc(sizeof(struct tnode));
  //  markNodeForGarbageCollection(p);
    p = p->next;

  }

  fclose(fp);

  p->type = type_empty_array;
  p->pd.type = type_empty_array;
  p->next = NULL;


  return dst;
}
#endif
