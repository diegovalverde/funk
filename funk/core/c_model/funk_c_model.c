
#include "funk_c_model.h"

struct tpool funk_global_memory_pool, funk_functions_memory_pool;
static uint32_t g_debug_continue = 0;

static char funk_types_str[][100]=
{
  "type_invalid",
  "type_int",
  "type_double",
  "type_array",
  "type_empty_array",
  "type_scalar",
  "type_function"
};
/*
  Exporting globals does not work very well with web-assembly
  this is why we use these enums instead
*/
struct tpool * get_pool_ptr(enum pool_types pool){
  switch(pool){
    case global_pool: return &funk_global_memory_pool;
    case function_pool: return &funk_functions_memory_pool;
    default: return NULL;
  }
}
// when compiling an application using debug mode
// the compiler updates the  g_funk_debug_current_executed_line for
// every instruction executed, you can then use this set breakpoints
// using the interactive debugger
#ifdef FUNK_DEBUG_BUILD
uint32_t g_funk_debug_current_executed_line = 0;
uint32_t g_funk_internal_function_tracing_enabled = 0;


#endif




#define VALIDATE_NODE(n) validate_node(n, __FUNCTION__)

struct tnode * validate_node(struct tnode * n, const char * function){

  if (n == NULL){
    printf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    printf("INTERNAL ERROR: '%s' NULL node\n",function);
    printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    return NULL;
  }
  if (n->pool != &funk_global_memory_pool && n->pool != &funk_functions_memory_pool){
    printf("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    printf("INTERNAL ERROR: '%s' n[%d:%d]{%p} pointer %p to memory pool is not valid\n",function,
    n->start, n->start + n->len, n,
    n->pool);
    printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
    return NULL;
  }

  return n;
}


struct tdata * get_node(struct tnode * n, uint32_t i, const char * caller, int line ){
  if (n == NULL){
    printf("INTERNAL ERROR: %s NULL node pointer\n",__FUNCTION__);
    exit(1);
  }
  if (VALIDATE_NODE(n) == NULL){
    printf("INTERNAL ERROR: called from %s:%d\n", caller, line);
    exit(1);
  }

  if (n->wrap_creation < n->pool->wrap_count && n->start <= n->pool->tail){
    printf("-E- attemping to access overwritten position in ring\n");
    exit(1);
  }
  uint32_t idx = (n->start + i);

  #ifdef FUNK_DEBUG_BUILD
  if (idx !=0 && (idx % FUNK_MAX_POOL_SIZE == 0)){
    printf("%s wrapping around %d + %d = %d:%d\n", __FUNCTION__, n->start, i, idx, n->len);
  }

  if (n->pool != &funk_global_memory_pool && n->pool != &funk_functions_memory_pool){
    printf("%s pointer %p to memory pool is not valid\n",__FUNCTION__,n->pool);
  }
  #endif
  return &(n->pool->data[idx % FUNK_MAX_POOL_SIZE]);
}



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
    pool->wrap_count++;
    printf("%s -I- wrapping around pool %s. tail = %d, max = %d. Wrap Count %d\n", __FUNCTION__,
    ((pool == &funk_global_memory_pool)?"gpool":"fpool"),
     pool->tail, FUNK_MAX_POOL_SIZE, pool->wrap_count);
    g_debug_continue = 0;

  }
  pool->tail = (pool->tail + len) % FUNK_MAX_POOL_SIZE;
}

void funk_print_node_info(struct tnode * n){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("START %s \n", __FUNCTION__);
  #endif
  printf("%p\n", n);
  printf("%s[%d :%d] %d-d\n",((n->pool == &funk_global_memory_pool)?"gpool":"fpool"), n->start, n->len, n->dimension.count );
  printf("int: %d\n", GET_NODE(n,0)->data.i);
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
  dst->wrap_creation = src->pool->wrap_count;

  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("END %s \n", __FUNCTION__);
  #endif

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

void funk_sum_list(struct tnode * src, struct tnode * dst){
  #ifdef FUNK_DEBUG_BUILD
  printf("%s ", __FUNCTION__);
  print_scalar(src);

  #endif

  uint32_t total = 0;
  uint32_t m = src->len;

  if (src->dimension.count == 2) {
    m = src->dimension.d[0]*src->dimension.d[1];
  }

  for (uint32_t i = 0; i <= m; i++)
  {
    total += GET_NODE(src,i)->data.i;
  }

  GET_NODE(dst,0)->data.i = total;
  dst->len = 1;
  dst->dimension.count = 1;



}

void funk_init(void){

  unsigned int seed = (unsigned int)time(NULL);
  srand(seed);
  funk_global_memory_pool.tail = 0;
  funk_global_memory_pool.wrap_count = 0;
  funk_functions_memory_pool.tail = 0;
  funk_functions_memory_pool.wrap_count = 0;

#ifdef FUNK_DEBUG_BUILD
    for (int i = 0; i < FUNK_MAX_POOL_SIZE; i++){
      funk_global_memory_pool.data[i].data.i = 0;
    }
    printf("===== FUNK better-than-nothing debugger =====\n");
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

void funk_create_list_slide_2d_lit(struct tnode * src, struct tnode * dst , int32_t idx_0, int32_t idx_1){

    // negative indexes allow getting last elemets like in python
    idx_0 = (idx_0 < 0) ? src->dimension.d[0] + idx_0 : idx_0;
    idx_1 = (idx_1 < 0) ? src->dimension.d[1] + idx_1 : idx_1;

    idx_0 %= src->dimension.d[0];
    idx_1 %= src->dimension.d[1];
/*
    if (idx_1 >= src->dimension.d[0]){
      printf("-E- %s index %d out of array boundary %u\n",__FUNCTION__, idx_1, src->dimension.d[0]);
    }

    if (idx_0  >= src->dimension.d[1]){
      printf("-E- %s index %d out of array boundary %u\n",__FUNCTION__, idx_0, src->dimension.d[1]);
    }
*/
    dst->pool = src->pool;
    dst->wrap_creation = src->pool->wrap_count;
    dst->dimension.count = 0;
    dst->len = 1;
    dst->start = (src->start + src->dimension.d[0]* idx_0 + idx_1) % FUNK_MAX_POOL_SIZE;

    #ifdef FUNK_DEBUG_BUILD
    funk_debug_register_node(dst);
    #endif

}

void funk_create_list_slide_2d_var(struct tnode * src, struct tnode * dst , struct tnode * node_i, struct tnode * node_j){

  if (GET_NODE(node_i, 0)->type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, GET_NODE(node_i,0)->type );
  }

  if (GET_NODE(node_j,0)->type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, GET_NODE(node_j,0)->type );
  }

  int32_t idx_0 = GET_NODE(node_i,0)->data.i;
  int32_t idx_1 = GET_NODE(node_j,0)->data.i;

 funk_create_list_slide_2d_lit(src, dst, idx_0, idx_1);

}

void funk_create_list_slide_1d_lit(struct tnode * src, struct tnode * dst, int32_t idx){
  // negative indexes allow getting last elemets like in python
  idx = (idx < 0) ? src->len + idx : idx;
  idx %= src->len;

  dst->pool = src->pool;
  dst->wrap_creation = src->pool->wrap_count;
  dst->dimension.count = 0;
  dst->len = 1;
  dst->start = (src->start + idx) % FUNK_MAX_POOL_SIZE;

  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(dst);
  #endif


}

void funk_create_list_slide_1d_var(struct tnode * src, struct tnode * dst , struct tnode * node_i){
  if (GET_NODE(node_i,0)->type != type_int){
    printf("-E- %s node lhs data type is %d but shall be int\n",
      __FUNCTION__, GET_NODE(node_i,0)->type );
  }

  int32_t idx_0 = GET_NODE(node_i, 0)->data.i;

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
  dst->wrap_creation = src->pool->wrap_count;
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

void add_node_to_nodelist(struct tnode * list, struct tnode * node,
  struct tnode * idx_node, int32_t list_len){

  VALIDATE_NODE(node);
  VALIDATE_NODE(idx_node);

  int32_t idx = GET_NODE(idx_node,0)->data.i;
  //printf("START %s ========= Will copy node[0:%d] into list[%d] >>>>>>>>>>>>>>>>>> N[%d]\n", __FUNCTION__,

  //int32_t k = 0;
  //TODO k < node->len only when len != 0
  //printf("pointer list_len: %d node->len: %d \n", list_len, node->len);
  int32_t k = 0;
  for (int i = idx; (k < node->len) && (i < list_len); i++){
    //printf("i: %d k: %d nl: %d ll:%d \n", i, k, node->len, list_len);
    list[i].pool  = node->pool;
    list[i].wrap_creation = node->pool->wrap_count;
    list[i].start = node->start + k;
    list[i].len = 1;
    list[i].dimension.count = 1;
    //printf("list[%d] = node{%p}[%d + %d]\n", i, node, node->start, k);
    //funk_copy_node(&list[i], node);
    //funk_print_node_info(&list[i]);
    GET_NODE(idx_node,0)->data.i += 1;
    k++;
    }


  //printf("END %s =============Copied up to index %d \n", __FUNCTION__, GET_NODE(idx_node,0)->data.i);

}

void funk_regroup_list(enum pool_types pool_type, struct tnode * n, struct tnode * list , int32_t size ){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
    printf("%s ", __FUNCTION__);
  #endif

  struct tpool * pool = get_pool_ptr(pool_type);
  n->pool = pool;
  n->wrap_creation = pool->wrap_count;
  n->dimension.count = 1;

  //printf("START %s ======================\n",__FUNCTION__);

  if (is_list_consecutive_in_memory(list, size) == 1){
    n->start = list[0].start;
    n->len = size;

  } else {
    //printf("->>>>> I- List is not consecutive in pool. Will create a copy\n");
    n->start  = pool->tail;
    n->len = size;

    funk_increment_pool_tail(pool, size);

    for (int i = 0; i < size; i++){

      struct tdata * p = GET_NODE(&list[i],0);
      *GET_NODE(n,i) = *p;

    }

  }


  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(n);
  #endif
}

void funk_create_2d_matrix(enum pool_types pool, struct tnode * node, struct tnode * list, int32_t n, int32_t m ){
  #ifdef FUNK_DEBUG_BUILD
  if(g_funk_internal_function_tracing_enabled)
    printf("%s ", __FUNCTION__);
  #endif

  funk_regroup_list(pool, node, list, n*m );
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
  n->wrap_creation = pool->wrap_count;

  funk_increment_pool_tail(pool,1);

  GET_NODE(n,0)->type = type;


  switch (type) {
    case type_int:
    GET_NODE(n,0)->data.i = *(int*)val;
    break;

    case type_double:
    GET_NODE(n,0)->data.f = *(double*)val;
    break;
  }

  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(n);
  #endif

}

void funk_create_int_scalar(enum pool_types pool, struct tnode * n, int32_t val){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
    printf("%s %s[%d] = %d\n", __FUNCTION__, ((pool == &funk_global_memory_pool)?"gpool":"fpool"),
    pool->tail, val);
  #endif



  funk_create_scalar(get_pool_ptr(pool), n, (void*)&val, type_int);
  VALIDATE_NODE(n);
  //printf("\nEnd %s %p\n",__FUNCTION__, n  );
}

void funk_create_float_scalar(struct tpool * pool, struct tnode * n, double val){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
    printf("%s %s[%d] = %f\n", __FUNCTION__, ((pool == &funk_global_memory_pool)?"gpool":"fpool"),
    pool->tail, val);
  #endif

  funk_create_scalar(pool, n, (void*)&val, type_double);
}

void funk_create_list_int_literal(enum pool_types pool_type, struct tnode * n, int32_t * list , int32_t size ){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s ", __FUNCTION__);
  #endif

  struct tpool * pool = get_pool_ptr(pool_type);

  n->start  = pool->tail;
  n->len = size;
  n->pool = pool;
  n->wrap_creation = pool->wrap_count;
  n->dimension.count = 1;

  funk_increment_pool_tail(pool, size);


  for (int i = 0; i < size; i++){
    GET_NODE(n,i)->type = type_int;
    GET_NODE(n,i)->data.i = list[i];
  }

  #ifdef FUNK_DEBUG_BUILD
  funk_debug_register_node(n);
  #endif

}

void funk_create_2d_matrix_int_literal(enum pool_types  pool_type, struct tnode * node, int32_t * list , int32_t n, int32_t m ){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s ", __FUNCTION__);
  #endif

  // Internally matrices are representes as contiguos
  // arrays in memory
  funk_create_list_int_literal(pool_type, node, list, n*m );
  node->dimension.count = 2;
  node->dimension.d[0] = n;
  node->dimension.d[1] = m;


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
  *type = GET_NODE(node, offset)->type;

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
  GET_NODE(node, offset)->type =  type;
}

void funk_increment_node_data_int(struct tnode  * node){

  GET_NODE(node,0)->data.i++;

}

void funk_copy_node_into_node_list(struct tnode  * dst_list, struct tnode * src, struct tnode * idx_node ){
  int32_t idx = GET_NODE(idx_node,0)->data.i;
  funk_copy_node(&dst_list[idx], src);

}

void funk_set_node_value_int(struct tnode  * node, uint32_t offset, uint32_t value){
  #ifdef FUNK_DEBUG_BUILD
  if (g_funk_internal_function_tracing_enabled)
      printf("%s ", __FUNCTION__);
  #endif

  if (offset >= node->len){
    printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, node->len);
  }
  GET_NODE(node, offset )->type = (unsigned char)type_int;
  GET_NODE(node, offset )->data.i = value;
}

int32_t funk_get_node_value_int(struct tnode * node, int32_t offset){
    if (offset > node->len){
      printf("-E- %s: offset %d out of bounds for len %d", __FUNCTION__, offset, node->len);
    }
    return GET_NODE(node, offset )->data.i;
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
   dst->wrap_creation = n->pool->wrap_count;
   dst->dimension.count = n->dimension.count;
   for (int i =0; i < FUNK_MAX_DIMENSIONS; i++){
     dst->dimension.d[i] = n->dimension.d[i];
   }

   if (n->len == 0){
     dst->start = n->start;
     dst->len = 1;
     GET_NODE(dst, 0)->type = type_empty_array;
     GET_NODE(dst, 0)->data.i = 0;
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
  funk_print_scalar_element(*GET_NODE(node_a, a_offset ));
  printf(" , ");
  printf("%s[%d]",((node_b->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_b->start + b_offset );
  funk_print_scalar_element(*GET_NODE(node_b, b_offset ));

  printf(" = %s[%d]",((node_r->pool == &funk_global_memory_pool)?"gpool":"fpool"),node_r->start + r_offset );
  funk_print_scalar_element(*GET_NODE(node_r, r_offset ));
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
                 void (*f)(void *, void *, void *, int )){


    if (a_offset > node_a->len){
      printf("-E- Invalid index %d is greater than array size of %d", a_offset, node_a->len );
    }

    if (b_offset > node_b->len){
      printf("-E- Invalid index %d is greater than array size of %d", b_offset, node_b->len );
    }

    if (r_offset > node_r->len){
      printf("-E- Invalid index %d is greater than array size of %d", r_offset, node_r->len );
    }

  struct tdata a = *GET_NODE(node_a, a_offset);
  struct tdata b = *GET_NODE(node_b, b_offset);
  struct tdata * r = GET_NODE(node_r, r_offset);

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

                  funk_create_int_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_sub);
                }

void funk_add_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                  struct tnode node_b;

                  funk_create_int_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_add);
                }

void funk_div_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                  struct tnode node_b;

                  funk_create_int_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_div);
                }

void funk_mul_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                  struct tnode node_b;

                  funk_create_int_scalar(function_pool, &node_b, value);
                  funk_arith_op_rr(node_r, r_offset,
                                   node_a, a_offset,
                                   &node_b, 0, funk_mul);
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
                funk_create_int_scalar(function_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_slt);

}

void funk_sgt_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                struct tnode node_b;
                funk_create_int_scalar(function_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_sgt);

}

void funk_sge_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                struct tnode node_b;
                funk_create_int_scalar(function_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_sge);

}

void funk_eq_ri(struct tnode * node_r, int32_t r_offset,
                struct tnode * node_a, int32_t a_offset,
                int value){

                struct tnode node_b;
                funk_create_int_scalar(function_pool, &node_b, value);
                funk_arith_op_rr(node_r, r_offset,
                                 node_a, a_offset,
                                 &node_b, 0, funk_eq);

}

void funk_print_dimension(struct tnode * n){
  printf("( ");
  for (uint32_t i = 0; i < n->dimension.count; i++){
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

    funk_print_scalar_element(*GET_NODE(n,0));

  } else if (n->dimension.count == 1){


    for (uint32_t i = 0; i < n->len; i++){
      funk_print_scalar_element(*GET_NODE(n,i));
    }


  } else if (n->dimension.count == 2){
    //printf(">------------------<\n");
    funk_print_node_info(n);
    printf("%d x %d \n",n->dimension.d[0], n->dimension.d[1]);

    for (uint32_t i = 0; i < n->dimension.d[1]; i++){
      for (uint32_t j = 0; j < n->dimension.d[0]; j++){
          funk_print_scalar_element(*GET_NODE(n, i * n->dimension.d[0] + j));
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
  int i_idx = GET_NODE(i,0)->data.i;
  int j_idx = GET_NODE(j,0)->data.i;
  //printf("XXXXXXX %d, %d: dimension %d", i_idx, j_idx, n->dimension.d[1]);
  funk_print_scalar_element(*GET_NODE(n, n->dimension.d[0]*i_idx + j_idx));
}

void print_2d_array_element_int_int(struct tnode * n, uint32_t i, uint32_t j){
  funk_print_scalar_element(*GET_NODE(n, n->dimension.d[0]*i + j));
}

float funk_ToFloat(struct tnode * n){
  if (GET_NODE(n,0)->type == type_int){
    return (float)GET_NODE(n,0)->data.i;
  } else if (GET_NODE(n,0)->type == type_double){
    return (float)GET_NODE(n,0)->data.f;
  } else {
    GET_NODE(n,0)->type = type_invalid;
    printf("ERROR %s",__FUNCTION__);
    exit(1);
    return 0.0f;
  }
}

void funk_read_list_from_file(enum pool_types  pool_type, struct tnode * dst, char * path ){

  struct tpool * pool = get_pool_ptr(pool_type);
  FILE *fp;
  fp = fopen(path, "rt");

  if (fp == NULL)
  {
    printf("-E- File '%s' cannot be read\n", path);
    exit(1);
  }


  int value = 0;
  int count = 0;

  //TODO: move to function
  dst->start = pool->tail;
  dst->dimension.count = 1;
  dst->pool = pool;
  dst->wrap_creation = pool->wrap_count;

  while(fscanf(fp,"%d",&value) == 1)
  {
    GET_NODE(dst, pool->tail)->data.i = value;
    GET_NODE(dst,pool->tail)->type = type_int;
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
  if (GET_NODE(dst,0)->type == type_empty_array){
    return;
  }
  dst->dimension.count = count;
  int number_of_elements = 1;
  for (int i = 0;  (i < count && i < FUNK_MAX_DIMENSIONS); i++){
    dst->dimension.d[i] = idx[i];
    number_of_elements *= dst->dimension.d[i];
  }

  //printf("%d:[%d x %d]\n", dst->dimension.count, dst->dimension.d[0],dst->dimension.d[1]);

  if (dst->len > 0u && number_of_elements > dst->len){
    printf("-E- reshape operation not possible for variable with %d elements\n", dst->len);
  }
}

void funk_get_len(struct tnode * src, struct tnode * dst){

  funk_create_int_scalar(function_pool, dst, src->len );

}

void funk_create_sub_matrix_lit_indexes(struct tnode * src, struct tnode * dst,
  int32_t r1, int32_t r2,
  int32_t c1, int32_t c2){

    if (r1 > r2){
      printf("%s Error r1 (%d) > r2 (%d)\n", __FUNCTION__,r1,r2 );
      exit(1);
    }

    if (c1 > c2){
      printf("%s Error c1 (%d) > c2 (%d)\n", __FUNCTION__,c1,c2 );
      exit(1);
    }


    int32_t n = abs((r2 - r1)+1);
    int32_t m = abs((c2 - c1)+1);

    int32_t * list = (int32_t *)malloc(sizeof(int32_t)*n*m);
    int k = 0;
    for (int i = r1; i <= r2; i++){
      for (int j = c1; j <= c2; j++){

        int idx_i = (i < 0) ? i + src->dimension.d[0] : i;
        int idx_j = (i < 0) ? j + src->dimension.d[1] : j;

        idx_i %= src->dimension.d[0];
        idx_j %= src->dimension.d[1];

        list[k] = GET_NODE(src, idx_i*src->dimension.d[0] +idx_j)->data.i;

        k++;

      }
    }


    funk_create_2d_matrix_int_literal(global_pool,  dst, list, n, m );
    free(list);

  }

void funk_create_sub_matrix(struct tnode * src, struct tnode * dst,
  struct tnode * R1,struct tnode * R2,
  struct tnode * C1, struct tnode *C2){
  if (src->dimension.count != 2){
    //funk_print_node_info(src);
    printf("Error: %s shall have 2 dimensions and not %d\n", __FUNCTION__, src->dimension.count);
    exit(1);
  }

  int32_t r1 = GET_NODE(R1,0)->data.i;
  int32_t r2 = GET_NODE(R2,0)->data.i;
  int32_t c1 = GET_NODE(C1,0)->data.i;
  int32_t c2 = GET_NODE(C2,0)->data.i;

  funk_create_sub_matrix_lit_indexes(src, dst, r1,  r2, c1,  c2);

}

void funk_set_node_dimensions(struct tnode  * node, int * dimensions, int count){
  node->dimension.count = count;

  if (dimensions == NULL)
    return;

  for (int i = 0; ((i < count) && (i < FUNK_MAX_DIMENSIONS)); i++){
    node->dimension.d[i] = dimensions[i];
  }

}
