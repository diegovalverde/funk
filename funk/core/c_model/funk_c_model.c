#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <unistd.h>

enum types{
type_invalid = 0,
type_int = 1,
type_double = 2,
type_array = 3,
type_empty_array = 4,
type_scalar = 5,
type_function = 6,
};

int g_funk_print_array_max_elements = 30;
int g_funk_print_array_element_per_row = 50;



struct tdata
{
  unsigned char type;

  union data_type{
    double f;
    int i;

  } data;

};


struct tnode
{
  unsigned char type;
  struct tdata pd;
  struct tnode * next;
  int refCount;
};


void funk_set_config_param(int id, int value){
  printf("-I- Setting conf parameter %d to value %d\n", id, value);
  switch (id){
    case 0:
      g_funk_print_array_max_elements = value;
      break;
    defaut:
      break;
  };

}

char * printNodeType(int type){
  switch(type){
    case type_invalid: return "invalid_type"; break;
    case type_int: return "int"; break;
    case type_double: return "double"; break;
    case type_array: return "array"; break;
    case type_empty_array: return "empty_array"; break;
    case type_scalar: return "scalar"; break;
    case type_function: return "function"; break;
    default:
      return "unknown";
  }
}

void funk_debug_printNode(struct tnode * n){

  if (NULL == n){
    printf("Node = nullptr\n");
    return;
  }
  printf("addr: %p ",n);
  switch(n->pd.type){
    case type_invalid:
       printf("data_type 'invalid_type' node_type %s",printNodeType(n->type));
      break;
    case type_int:
      printf("data_type 'int' value %d node_type %s",n->pd.data.i,printNodeType(n->type));
      break;
    case type_double:
      printf("data_type 'double' value %f node_type %s",n->pd.data.f,printNodeType(n->type));
      break;
    case type_array:
      printf("data_type 'array'node_type %s",printNodeType(n->type));
      break;
    case type_empty_array:
      printf("data_type 'empty_array' node_type %s",printNodeType(n->type));
      break;
    case type_scalar:
      printf("data_type 'scalar' value %d node_type %s",n->pd.data.i,printNodeType(n->type));
      break;
    case type_function:
      printf("data_type 'function' node_type %s",printNodeType(n->type));
      break;
    default:
      printf("data_type '?' node_type %s",printNodeType(n->type));
  }

  if (n->refCount == -1){
    printf(" [variable in the STACK]\n");
  } else {
    printf("ref_cnt %d\n", n->refCount);
  }

}


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
    r->pd.type = type_invalid;
  }

}

void funk_eq_ri(struct tnode * r, struct tnode * n1, int lit){
  if (n1->pd.type == type_double){
      r->pd.data.f = n1->pd.data.f * (float)lit;
      r->pd.type = type_double;
  } else if (n1->pd.type == type_int ){
    r->pd.data.i = (n1->pd.data.i == lit) ? 1 : 0;
    r->pd.type = type_int;
  } else {
    //Invalid data
    printf("funk_eq_ri: invalid types %d\n ", n1->pd.type);
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

void funk_mul_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
  if (n1->pd.type == type_double && n2->pd.type == type_double){
      r->pd.data.f = n1->pd.data.f * n2->pd.data.f;
      r->pd.type = type_double;
  } else if (n1->pd.type == type_int && n2->pd.type == type_int){
    r->pd.data.i = n1->pd.data.i * n2->pd.data.i;
    r->pd.type = type_int;
  } else if (n1->pd.type == type_double && n2->pd.type == type_int){
    r->pd.data.f = n1->pd.data.f * (double)(n2->pd.data.i);
    r->pd.type = type_double;
  } else if (n1->pd.type == type_int && n2->pd.type == type_double){
    r->pd.data.f = (double)n1->pd.data.i * n2->pd.data.f;
    r->pd.type = type_double;
  } else {
    //Invalid data
    printf("-E- funk_mul_rr: invalid types %d, %d\n ", n1->pd.type, n2->pd.type);
    r->pd.type = type_invalid;
  }

}

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

void init_random_seed(void){
  unsigned int seed = (unsigned int)time(NULL);
  //printf("-I- init_random_seed: %d\n", seed);
  srand(seed);
}

void funk_print_scalar_element(struct tnode * n){

    switch( n->pd.type ){
      case type_int:
        printf(" %d ", n->pd.data.i);
        break;
      case type_double:
        printf(" %f ", n->pd.data.f);
        break;
      default:
        printf("-E- Cannot print type %d\n", n->pd.type);
    }
}



void print_scalar(struct tnode * n){

  if (n->type == type_array){
    struct tnode * p = n;
    int cnt = 0;
    printf("[ ");
    while(p->next !=NULL && cnt < g_funk_print_array_max_elements){
      funk_print_scalar_element(p);
      if (cnt > 0 && ((cnt % g_funk_print_array_element_per_row) == 0)){
        printf("\n");
      }
      p = p->next;
      cnt++;
    }

    if (p->next != NULL){
      printf(" ... ");
    }
    printf(" ]");

  } else {
    funk_print_scalar_element(n);
  }

}

struct tnode * funk_concatenate_lists(struct tnode * left, struct tnode * right){
  int i = 0;
  struct tnode * p = left;
  while(p && p->next->type != type_empty_array)
  {
    printf(".");
    funk_debug_printNode(p);
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

  //funk_debug_printNode(head);

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
    node->type = 3; //List Node
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
   tail->type = 4; //empty_array
   tail->pd.type = type;

   if (node != NULL)
      node->next = tail;

   if (head == NULL)
      head = tail;

   tail->next = NULL;
   tail->pd.data.i = i;
   return head;
}

void funk_memcp_arr(struct tnode * dst, struct tnode * src, int n, unsigned char dst_on_stack){
  for (int i = 0; i < n; ++i){
      dst[i] = src[i];
      if (dst_on_stack == 1){
        dst[i].refCount = -1; //Just mark it to be on the stack
      }
  }

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
