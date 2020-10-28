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

uint32_t g_funk_debug_current_executed_line = 0;
enum types{
type_invalid = 0,
type_int = 1,
type_double = 2,
type_array = 3,
type_empty_array = 4,
type_scalar = 5,
type_function = 6,
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

void funk_create_int_scalar(struct tpool * pool, struct tnode * n, int32_t val){
  n->start  = pool->tail;
  n->len = 1;
  n->pool = pool;
  n->dimension.count = 1;

  pool->tail = (pool->tail + 1) % FUNK_MAX_POOL_SIZE;

  pool->data[n->start].type = type_int;
  pool->data[n->start].data.i = val;

}

void funk_create_list_int_literal(struct tpool * pool, struct tnode * n, int32_t * list , int32_t size ){
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
  // Internally matrices are representes as contiguos
  // arrays in memory
  funk_create_list_int_literal(pool, node, list, n*m );
  node->dimension.count = 2;
  node->dimension.d[0] = n;
  node->dimension.d[1] = m;
  printf(">>>>> %d %d pool_tail: %d\n", node->start, node->len, pool->tail );

}

void funk_copy_element_from_pool(struct tpool * pool, struct tnode * dst, struct tnode * src, int32_t i, int32_t j){
  int32_t offset = (src->dimension.d[0] * i) + j;

  if (offset >= src->len){
      printf("-E- Indexes %d, %d are out of bounds\n", i, j);
  } else {
      dst->start = src->start + offset;
      dst->len = 1;
  }

}

void funk_debug_function_entry_hook(void){


  #ifdef FUNK_DEBUG_BUILD
  printf("Stopped at the beginning of function\n");
  char str[8];
  fgets(str,8,stdin);

  #endif
}






void funk_memcp_arr(struct tnode * dst, struct tnode * src, int n, unsigned char dst_on_stack){
  for (int i = 0; i < n; ++i){
      dst[i] = src[i];

  }

}


void funk_mul_rr(struct tnode * node_r, int32_t r_offset,
                 struct tnode * node_a, int32_t a_offset,
                 struct tnode * node_b, int32_t b_offset)
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

  struct tdata a = node_a->pool->data[a_offset];
  struct tdata b = node_b->pool->data[b_offset];
  struct tdata * r = &(node_r->pool->data[r_offset]);

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
void funk_print_scalar_element(struct tdata n){

    switch( n.type ){
      case type_int:
        printf(" %d, ", n.data.i);
        break;
      case type_double:
        printf(" %f, ", n.data.f);
        break;
      default:
        printf(" ? ");
    }
}


void funk_print_dimension(struct tnode * n){
  printf("( ");
  for (int i = 0; i < n->dimension.count; i++){
    printf("%d ", n->dimension.d[i]);
  }
  printf(")");
}
void print_scalar(struct tnode * n){
  // printf("start: %d end: %d", n->start, n->len);
  // funk_print_dimension(n);
  //
  // for (int i = 0; i < 32; i++){
  //
  //   funk_print_scalar_element(funk_global_memory_pool.data[i]);
  //   if (i >0 && i % 16 == 0)
  //     printf("\n" );
  // }

  if (n->dimension.count == 0){

    funk_print_scalar_element(n->pool->data[n->start]);

  } else if (n->dimension.count == 1){

    printf(" [ ");
    for (int i = n->start; i < (n->start + n->len); i++){
      funk_print_scalar_element(n->pool->data[i]);
    }
    printf(" ]  ");

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
