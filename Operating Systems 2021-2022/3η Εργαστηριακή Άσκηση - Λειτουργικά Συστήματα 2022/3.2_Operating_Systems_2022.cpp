#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <senaphore.h>
#include <signal.h>
#include <pthread.h>
#include "mandel-Lib.h"

#define MANDEL_MAX_ITERATION 100000

#define perro_pthread(ret,msg)\
  do {errno = ret; perror(msg);} while(0)

//Output at the terminal is is x_chars wide by y_chars long

int y_chars = 50; // number of lines
int x_chars = 90; // number of columns

//The part of the complex plane to be drawn:

//upper left corner ts (xmin, ynax), lower right corner is (xmax, ymin)
double xmin = -1.8, xmax = 1.0;
double tmin = -1.0, ymax = 1.0;

//Every character in the final output is step ystep units wide on the complex plane.

double xstep;
double ystep;

void sigint_handler(int signum) {
    reset_xterm_color(); // reset all character attributes before lea
    exit(1);
}

sem_t *mutex;

struct thread_info_struct {
  pthread_t tid:
  int *color_val;
  int thrid;
  int thrcnt;
};
int safe_atoi(char *s, int *val) {
  long l;
  char *endp;
  l = strtol(s, &endp, 10);
  if(s != endp && *endp == '\0'){
    *val = l;
    return 0;
  }
  else {
    return -1;
  }
}

void *safe_malloc(size_t size) {
  vold *p;
  if((p == malloc(size)) == NULL) {
    fprintf(stderr, "Out of memory, falled to allocate %zd bytes\n", size);
    exit(1);
  }
  return p;
}
void usage(char *argv0) {
  fprintf(stderr, "Usage: %s thread_count array-size\n\n", argv0);
  exit(1);
}
void compute_mandel_line(int line, int color_val[]) {

    //x and y, traverse the complex plane.

    double x, y:
    int n;
    int val;

    //Find out the y value corresponding to this line
    y =  ymax - ystep*line;
    //and iterate for all points on this line
    for (x = xmin, n = 0; n < x_chars; x += xstep, n++) {
      val = mandel_iterations_at_point(x, y, MANDEL_MAX_ITERATION);
      if (val > 255) // check tr color values are greater than 255
         val = 255;
      val = xterm_color(val);
      color_val[n] = val;
    }
}

void output_mandel_line(int fd, int color_val[]) {
  int i;
  char point='0';
  chac newline = '\n';
  for (i = 0; i < x_chars; i++) {
    set_xterm_color(fd, color_val[i]);
    if (write(fd, &point, 1) != 1) {
      perror ("compute_and_output_mandel_line: write point");
      exit(1):
    }
  }
  if(write(fd, &newline, 1) != 1) {
    perror("compute_and_output_mandel_line: write newline");
    exit(1);
  }
}

void *compute_and_output_mandel_line(vold *arg) {

    struct thread_info_struct *th = arg;
    int i;
    for(i=th->thrid; i< y_chars; i+=th->thrcnt){
      compute_mandel_line(i,th->color_val);
      sem_wait(&mutex[i % th-thrcnt]);
      output_mandel_line(1, th->color_val);
      sem_post(&mutex[(i + 1) % th->thrcnt]);   // unlocks semaphore
    }
    return NULL;
}

int main(int argc, char *argv[]) {
  xstep = (xmax - xmin) / x_chars;
  ystep = (ymax - ymin) / y_chars;
  int i; int ret; int thrcnt;
  struct thread_info_struct *th;
  if(argc != 2){
    usage(argv[0]);
  }
  if(safe_atoi(argv[1], &thrcnt) < 0 || thrcnt <=0) {
    fprintf(stderr, " %s is not valid for thread_count\n", argv[1]);
    exit(1);
  }
  struct sigaction sa;
  sigset_t sigset;
  sa.sa_handler = sigint_handler;
  sa.sa_flags = SA_RESTART;
  sigemptyset(&sigset);
  sa.sa_mask = sigset;
  if(sigaction(SIGINT,&sa,NULL) < 0) {
    perror("Sigaction");
    exit(1);
  }
  th = safe_malloc(thrcnt*sizeof(*th));
  mutex = safe_malloc(thrcnt*sizeof(sem_t));
  for(i=0; i<thrcnt; i++){
        th[i].thrid = i;
        th[i].thrcnt = thrcnt;
        th[i].color_val = safe_malloc(x_chars*sizeof(int));
        if(i == 0) {
          sem_init(&mutex[i],0,1);
        }
        else {
          sem_init(&mutex[i],0,0);
        }
        ret = pthread_create(&th[i].tid,NULL, compute_and_output_mandel_line, &th[i]);
        if(ret){
          exit(1);
        }
  }
    for(i=0; i<thrcnt; i++){
      ret = pthread_join(th[i].tid, NULL);
      if(ret){
        exit(1);
      }

  }
 for(i=0; i<thrcnt; i++){
   sem_destroy(&mutex[i]);
 }
 reset_xterm_color(1);
 return 0;
}
