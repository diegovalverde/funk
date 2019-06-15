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
type_function = 5,
};

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
  if (n1->pd.type == 2){
      r->pd.data.f = n1->pd.data.f * (float)lit;
      r->pd.type = 2;
  } else if (n1->pd.type == 1 ){
    r->pd.data.i = (n1->pd.data.i == lit) ? 1 : 0;
    r->pd.type = 1;
  } else {
    //Invalid data
    r->pd.type = 0;
  }

}

void funk_or_rr(struct tnode * r, struct tnode * n1, struct tnode * n2){
  if (n1->pd.type == type_int && n2->pd.type == type_int){
      r->pd.data.i = ((n1->pd.data.i != 0) || (n2->pd.data.i != 0)) ? 1 : 0;
      r->pd.type = type_int;
  } else if (n1->pd.type == type_double && n2->pd.type == type_double){
    r->pd.data.f= ((n1->pd.data.i != 0.0f) || (n2->pd.data.i != 0.0f)) ? 1.0f : 0.0f;
    r->pd.type = type_double;
  } else if (n1->pd.type != n2->pd.type){
    //Invalid data
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
    //Invalid data
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
    //Invalid data
    r->pd.type = 0;
  }

}

int rand_range(int lower, int upper){

  return rand() % (upper - lower + 1) + lower;


}

void init_random_seed(void){
  unsigned int seed = (unsigned int)time(NULL);
  printf("-I- init_random_seed: %d\n", seed);
  srand(seed);
}


void print_scalar(struct tnode * n){
  switch( n->pd.type ){
    case type_int:
      printf("%d", n->pd.data.i);
      break;
    case type_double:
      printf("%f", n->pd.data.f);
      break;
    default:
      printf("-E- Cannot print type %d\n", n->pd.type);
  }
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
      printf(".");
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
    printf("+");
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
  printf("register alloc %p ref_cnt %d\n", n, n->refCount);

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
   tail->type = 4; //empty_array
   tail->pd.type = type_int;

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

void funk_memcp_arr(struct tnode * dst, struct tnode * src, int n){
  for (int i = 0; i < n; ++i){
      dst[i] = src[i];
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
