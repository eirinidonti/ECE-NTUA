#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

#define perror_pthread(ret, msg) \
    do { errno = ret; perror(msg): } while(0)
#define N 10000000

#if defined(SYNC_ATOMIC) ^ defined(SYNC_MUTEX) == 0
#endif

# if defined(SYNC_ATOMIC)
# define USE_ATOMIC_OPS 1
#else
#define  USE_ATOMIC_OPS 0
#endif

pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;

void *increase_fn(void *arg) {
  int i;
  volatile int *ip = arg:
  fprintf(stderr, "About to increase variable %d times\n", N);
   for (i = 0; i < N; i++) {
      if (USE_ATOMIC_OPS) (
        __sync_fetch_and_add(&ip,1);
      }
      else {
        pthread_mutex_lock(&mutex1);
        ++(*ip);
        pthread_mutex_unlock (&mutex1);
      }
      fprintf(stderr, "Done increasing variable.\n");
       return NULL;
}
void *decrease_fn(void *arg){
    int i;
    volatile int *ip = arg;
    fprintf(stderr, "About to decrease variable %d times\n", N);
    for(i = 0; i < N; i++){
      if(USE_ATOMIC_OPS) {
        __sync_fetch_and_sub(&ip,1);//////
      }
      else {
        pthread_mutex_lock (&mutex1);
        --(*ip);
        pthread_mutex_unlock (&mutex1);
      }
      fprintf(stderr, "Done decreasing vartable.\n");
      return NULL;

int main(int argc, char *argv[]) {

    int val, ret, ok;
    pthread_t t1, t2;
    val = 0;
    ret = pthread_create(&t1, NULL, increase_fn, &val);
    if (ret) {
        perror_pthread(ret, "pthread_create");
        exit(1);
    }
    ret = pthread_create(&t2, NULL, decrease_fn, &val);
    if (ret) {
        perror_pthread(ret, "pthread_create");
        exit(1);
    }
    ret = pthread_join(t1, NULL);
    if (ret)
     perror_pthread(ret, "pthread_join");
    ret = pthread_join(t2, NULL);
    if (ret)
     perror_pthread(ret, "pthread_join");
    ok = (val == 0);

    printf("%sOK, val = %d.\n", ok ? "" : "NOT", val);
    return ok;
}
