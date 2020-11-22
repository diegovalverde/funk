#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>


//#define FUNK_DEBUG_BUILD 1

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

struct tdata * get_node(struct tnode * n, uint32_t i){

  uint32_t idx = (n->start + i);
  #ifdef FUNK_DEBUG_BUILD
  if (idx !=0 && (idx % FUNK_MAX_POOL_SIZE == 0)){
    printf("%s wrapping around %d + %d = %d:%d\n", __FUNCTION__, n->start, i, idx, n->len);
  }
  #endif
  return &(n->pool->data[idx % FUNK_MAX_POOL_SIZE]);
}

struct tnode gRenderLoopState;


#ifdef FUNK_DEBUG_BUILD
void print_scalar(struct tnode * n);

 #define SZ_DBG_NODES 1024
 struct tnode g_debug_nodes[SZ_DBG_NODES];
 int32_t g_debug_node_tail = 0;

 void funk_debug_register_node(struct tnode * n)
 {
   g_debug_nodes[g_debug_node_tail] = *n;
   g_debug_node_tail = (g_debug_node_tail + 1) % SZ_DBG_NODES;
 }

 #define INSIDE(x,a,b) (x >= a && x <= b)

 void funk_print_node_info(struct tnode * n);

 void funk_print_nodes(struct tpool * pool){
   for (int i =0; i < g_debug_node_tail; i++){
     if (pool == g_debug_nodes[i].pool){
        printf("%d: ",i); funk_print_node_info(&g_debug_nodes[i]); printf("\n");}
   }
 }

 void funk_debug_collision_checker(void){
   for (int i = 0; i < FUNK_MAX_POOL_SIZE; i++){
     for (int j = 0; j < FUNK_MAX_POOL_SIZE; j++){
       if (i == j)
        continue;


       if (g_debug_nodes[i].pool == g_debug_nodes[j].pool &&
       (INSIDE(g_debug_nodes[i].start, g_debug_nodes[j].start, g_debug_nodes[j].start + g_debug_nodes[j].len) ||
       INSIDE(g_debug_nodes[j].start, g_debug_nodes[i].start, g_debug_nodes[i].start + g_debug_nodes[i].len) ||
       INSIDE(g_debug_nodes[i].start + g_debug_nodes[i].len, g_debug_nodes[j].start, g_debug_nodes[j].start + g_debug_nodes[j].len) ||
       INSIDE(g_debug_nodes[j].start + g_debug_nodes[j].len, g_debug_nodes[i].start, g_debug_nodes[i].start + g_debug_nodes[i].len)))
       {
         printf("collision ");
         funk_print_node_info(&g_debug_nodes[i]);
         funk_print_node_info(&g_debug_nodes[j]);
       }

     }
   }
 }

#endif


void funk_sleep(int aSeconds){
  static int first = 1;
  if (first){
    first = 0;
    return;
  }
  sleep(aSeconds);
}

void funk_increment_pool_tail(struct tpool * pool, uint32_t len){
  if (pool == &funk_global_memory_pool && (pool->tail + len >= FUNK_MAX_POOL_SIZE) ){
    printf("%s -I- wrapping around pool %s. tail = %d, max = %d\n", __FUNCTION__,
    ((pool == &funk_global_memory_pool)?"gpool":"fpool"),
     pool->tail, FUNK_MAX_POOL_SIZE);
    g_debug_continue = 0;
  }
  pool->tail = (pool->tail + len) % FUNK_MAX_POOL_SIZE;
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


  funk_copy_node( &gRenderLoopState, n);


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

  //(&gRenderLoopState);

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

  if (get_node(node_i, 0)->type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, get_node(node_i,0)->type );
  }

  if (get_node(node_j,0)->type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, get_node(node_j,0)->type );
  }

  int32_t idx_0 = get_node(node_i,0)->data.i;
  int32_t idx_1 = get_node(node_j,0)->data.i;


  // negative indexes allow getting last elemets like in python
  idx_0 = (idx_0 < 0) ? src->dimension.d[0] + idx_0 : idx_0;
  idx_1 = (idx_1 < 0) ? src->dimension.d[1] + idx_1 : idx_1;

  idx_0 %= src->dimension.d[0];
  idx_1 %= src->dimension.d[1];

  if (idx_1 >= src->dimension.d[0]){
    printf("-E- %s index %d out of array boundary %d\n",__FUNCTION__, idx_1, src->dimension.d[0]);
  }

  if (idx_0  >= src->dimension.d[1]){
    printf("-E- %s index %d out of array boundary %d\n",__FUNCTION__, idx_0, src->dimension.d[1]);
  }

  dst->pool = src->pool;
  dst->dimension.count = 0;
  dst->len = 1;
  dst->start = (src->start + src->dimension.d[0]* idx_0 + idx_1) % FUNK_MAX_POOL_SIZE;

  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(dst);
  #endif

}

void funk_create_list_slide_1d_lit(struct tnode * src, struct tnode * dst, int32_t idx){
  // negative indexes allow getting last elemets like in python
  idx = (idx < 0) ? src->len + idx : idx;
  idx %= src->len;

  dst->pool = src->pool;
  dst->dimension.count = 0;
  dst->len = 1;
  dst->start = (src->start + idx) % FUNK_MAX_POOL_SIZE;

  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(dst);
  #endif


}

void funk_create_list_slide_1d_var(struct tnode * src, struct tnode * dst , struct tnode * node_i){
  if (get_node(node_i,0)->type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, get_node(node_i,0)->type );
  }

  int32_t idx_0 = get_node(node_i, 0)->data.i;

  funk_create_list_slide_1d_lit(src, dst, idx_0);

}


void funk_create_list_slide_lit(struct tnode * src, struct tnode * dst , int32_t * idx, int32_t idx_cnt){


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
    dst->start = (src->start + idx[0]) % FUNK_MAX_POOL_SIZE;
  } else if (idx_cnt == 2){
    dst->start =  (src->start + dst->dimension.d[0]* idx[0] + idx[1])% FUNK_MAX_POOL_SIZE;
  } else {
    printf("-E- %s %d dimensions are not yet supported\n", __FUNCTION__, idx_cnt );
  }

  if (dst->start >= src->len){
    printf("-E- %s index %d out of range for len %d\n", __FUNCTION__, dst->start, src->len );
  }
  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(dst);
  #endif
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
    //printf("->>>>> I- List is not consecutive in pool. Will create a copy\n");
    n->start  = pool->tail;
    n->len = size;

    funk_increment_pool_tail(pool, size);
      //printf("NNNNNNN\n");
    for (int i = 0; i < size; i++){

      //printf("%d  ",get_node(&list[i],0)->data.i);

      *get_node(n,i) = *get_node(&list[i],0);

    }
      //printf("NNNNNNN\n");
  }
  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(n);
  #endif
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
  //printf(">>>>> %d %d pool_tail: %d\n", node->start, node->len, pool->tail );

  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(node);
  #endif
}

void funk_create_scalar(struct tpool * pool, struct tnode * n, void * val, int32_t type){


  n->start  = pool->tail;
  n->len = 1;
  n->pool = pool;
  n->dimension.count = 1;

  funk_increment_pool_tail(pool,1);

  get_node(n,0)->type = type;


  switch (type) {
    case type_int:
    get_node(n,0)->data.i = *(int*)val;
    break;

    case type_double:
    get_node(n,0)->data.f = *(double*)val;
    break;
  }

  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(n);
  #endif

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

  funk_increment_pool_tail(pool, size);


  for (int i = 0; i < size; i++){
    get_node(n,i)->type = type_int;
    get_node(n,i)->data.i = list[i];
  }

  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(n);
  #endif

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
  //printf(">>>>> %d %d pool_tail: %d\n", node->start, node->len, pool->tail );

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
        printf(" %3d ", n.data.i);
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
  *type = get_node(node, offset)->type;

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
  get_node(node, offset)->type =  type;
}

void funk_set_node_value_int(struct tnode  * node, uint32_t offset, uint32_t value){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s ", __FUNCTION__);
  #endif

  if (offset >= node->len){
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, node->len);
  }
  get_node(node, offset )->type = (unsigned char)type_int;
  get_node(node, offset )->data.i = value;
}

int32_t funk_get_node_value_int(struct tnode * node, int32_t offset){
    if (offset > node->len){
      printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, node->len);
    }
    return get_node(node, offset )->data.i;
}

void funk_print_pool(struct tpool * pool, int begin, int len){
  printf("tail @: %d\n", pool->tail);
   for (int i = begin; i < begin + len; i++){

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
     get_node(dst, 0)->type = type_empty_array;
     get_node(dst, 0)->data.i = 0;
   } else {
     dst->len = n->len - 1;
     dst->start = n->start+1;
   }

 }

void funk_debug_function_entry_hook(const char * function_name){

  #ifdef FUNK_DEBUG_BUILD

  char str[8];


  if (funk_global_memory_pool.tail + 1 == FUNK_MAX_POOL_SIZE){
    printf("\n\n\n=== funk_global_memory_pool.tail = %d about to reach max of %d\n", funk_global_memory_pool.tail, FUNK_MAX_POOL_SIZE);
  } else if (g_debug_continue == 1){
    return;
  }

  printf("\n\n\n=== %s === \n", function_name);
  do {
      printf(">");
      fgets(str,8,stdin);

      if (!strncmp(str,"gpool",5)){
        int begin, len;
        printf("begin len:");
        scanf("%d %d", &begin, &len);

        funk_print_pool(&funk_global_memory_pool, begin, len);
      } else if (!strncmp(str,"fpool",5)){
        funk_print_pool(&funk_functions_memory_pool,0,256);
      } else if (!strncmp(str,"r",1)){
        g_debug_continue = 1;
      } else if (!strncmp(str,"q",1)){
        exit(0);
      } else if (!strncmp(str,"fnod",4)){
        funk_print_nodes(&funk_functions_memory_pool);
      } else if (!strncmp(str,"gnod",4)){
        funk_print_nodes(&funk_global_memory_pool);
      } else if (!strncmp(str,"rs",2)){
        funk_print_node_info(&gRenderLoopState);
        printf("\n");
        print_scalar(&gRenderLoopState);

      } else if (!strncmp(str,"ftrace",6)){
        g_funk_internal_function_tracing_enabled = !g_funk_internal_function_tracing_enabled;
    }

  } while (strncmp(str,"c",1) && strncmp(str,"r",1));




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
  funk_print_scalar_element(*get_node(node_a, a_offset ));
  printf(" , ");
  printf("%s[%d]",((node_b->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_b->start + b_offset );
  funk_print_scalar_element(*get_node(node_b, b_offset ));

  printf(" = %s[%d]",((node_r->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_r->start + r_offset );
  funk_print_scalar_element(*get_node(node_r, r_offset ));
  printf(" )\n");
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

  struct tdata a = *get_node(node_a, a_offset);
  struct tdata b = *get_node(node_b, b_offset);
  struct tdata * r = get_node(node_r, r_offset);

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

void funk_add_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                  struct tnode node_b;

                  funk_create_int_scalar(&funk_functions_memory_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_add);
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

    funk_print_scalar_element(*get_node(n,0));

  } else if (n->dimension.count == 1){


    for (int i = 0; i < n->len; i++){
      funk_print_scalar_element(*get_node(n,i));
    }


  } else if (n->dimension.count == 2){
    //printf(">------------------<\n");
    funk_print_node_info(n);
    printf("%d x %d \n",n->dimension.d[0], n->dimension.d[1]);

    for (int i = 0; i < n->dimension.d[1]; i++){
      for (int j = 0; j < n->dimension.d[0]; j++){
          funk_print_scalar_element(*get_node(n, i * n->dimension.d[0] + j));
      }
      printf("\n");
    }
  } else {
    printf(" [...] %d-dimensional with %d elements\n", n->dimension.count, n->len);
  }

}

void print_2d_array_element_reg_reg(struct tnode * n, struct tnode * i, struct tnode * j){
  funk_print_node_info(n);
  if (n->dimension.count != 2){
    printf("%s Error cannot address as a matrix since node has %d dimensions", __FUNCTION__, n->dimension.count);
  }
  int i_idx = get_node(i,0)->data.i;
  int j_idx = get_node(j,0)->data.i;
  //printf("XXXXXXX %d, %d: dimension %d", i_idx, j_idx, n->dimension.d[1]);
  funk_print_scalar_element(*get_node(n, n->dimension.d[0]*i_idx + j_idx));
}

void print_2d_array_element_int_int(struct tnode * n, uint32_t i, uint32_t j){
  funk_print_scalar_element(*get_node(n, n->dimension.d[0]*i + j));
}

float funk_ToFloat(struct tnode * n){
  if (get_node(n,0)->type == type_int){
    return (float)get_node(n,0)->data.i;
  } else if (get_node(n,0)->type == type_double){
    return (float)get_node(n,0)->data.f;
  } else {
    get_node(n,0)->type = type_invalid;
    printf("ERROR %s",__FUNCTION__);
    exit(1);
    return 0.0f;
  }
}

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

  //TODO: move to function
  dst->start = pool->tail;
  dst->dimension.count = 1;
  dst->pool = pool;


  while(fscanf(fp,"%d",&value) == 1)
  {
    get_node(dst, pool->tail)->data.i = value;
    get_node(dst,pool->tail)->type = type_int;
    funk_increment_pool_tail(pool, 1);


    count++;
  }

  dst->len = count;


    #ifdef FUNK_DEBUG_BUILD
    funk_debug_register_node(dst);
    #endif
    //end TODO

  fclose(fp);


}

void reshape(struct tnode * dst, int * idx, int count){
  if (get_node(dst,0)->type == type_empty_array){
    return;
  }
  dst->dimension.count = count;
  int number_of_elements = 1;
  for (int i = 0;  (i < count && i < FUNK_MAX_DIMENSIONS); i++){
    dst->dimension.d[i] = idx[i];
    number_of_elements *= dst->dimension.d[i];
  }

  //printf("%d:[%d x %d]\n", dst->dimension.count, dst->dimension.d[0],dst->dimension.d[1]);

  if (dst->len > 0 && number_of_elements > dst->len){
    printf("-E- reshape operation not possible for variable with %d elements\n", dst->len);
  }
}


void funk_get_len(struct tnode * src, struct tnode * dst){

  funk_create_int_scalar(&funk_functions_memory_pool, dst, src->len );

}

void funk_create_sub_matrix(struct tnode * src, struct tnode * dst,
  struct tnode * r1,struct tnode * r2,
  struct tnode * c1, struct tnode *c2){
  if (src->dimension.count != 2){
    printf("%s Error shall have 2 dimensions and not %d\n", __FUNCTION__, src->dimension.count);
  }

  if (get_node(r1,0)->data.i > get_node(r2,0)->data.i){
    printf("%s Error r1 (%d) > r2 (%d)\n", __FUNCTION__,get_node(r1,0)->data.i,get_node(r2,0)->data.i );
  }

  if (get_node(c1,0)->data.i > get_node(c2,0)->data.i){
    printf("%s Error c1 (%d) > c2 (%d)\n", __FUNCTION__,get_node(c1,0)->data.i,get_node(c2,0)->data.i );
  }

  int32_t total = 0;
  int32_t n = (get_node(r2,0)->data.i - get_node(r1,0)->data.i)+1;
  int32_t m = (get_node(c2,0)->data.i - get_node(c1,0)->data.i)+1;

  int * list = (int *)malloc(sizeof(int32_t)*n*m);
  int k = 0;
  for (int i = get_node(r1,0)->data.i; i <= get_node(r2,0)->data.i; i++){
    for (int j = get_node(c1,0)->data.i; i <= get_node(c2,0)->data.i; i++){
      i %= src->dimension.d[0];
      j %= src->dimension.d[1];

      list[k] = get_node(src, i*src->dimension.d[0] +j)->data.i;
      k++;
    }
  }


  funk_create_2d_matrix_int_literal(&funk_global_memory_pool,  dst, list, n, m );
  free(list);
}
