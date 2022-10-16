/*
 * mandel.c
 *
 * A program to draw the Mandelbrot Set on a 256-color xterm.
 *
 */
#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <semaphore.h>
#include <errno.h>
#include <pthread.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <stdint.h>

#include "mandel-lib.h"
#include "help.h"

#define RED     "\033[31m"
#define RESET   "\033[0m"

#define MANDEL_MAX_ITERATION 100000

#define perror_pthread(ret, msg) \
        do { errno = ret; perror(msg); } while (0)

void handler(sig)
        int sig;
{
        reset_xterm_color(1);
        printf("\n");
        exit(1);
}

char *heap_private_buf;
char *heap_shared_buf;
sem_t *sem_array;

/***************************
 * Compile-time parameters *
 ***************************/

/*
 * Output at the terminal is is x_chars wide by y_chars long
*/
int y_chars = 50;
int x_chars = 90;

/*
 * The part of the complex plane to be drawn:
 * upper left corner is (xmin, ymax), lower right corner is (xmax, ymin)
*/
double xmin = -1.8, xmax = 1.0;
double ymin = -1.0, ymax = 1.0;

/*
 * Every character in the final output is
 * xstep x ystep units wide on the complex plane.
 */
double xstep;
double ystep;

//sem_t mutex1,mutex2;

int safe_atoi(char *s, int *val)
{
        long l;
        char *endp;

        l = strtol(s, &endp, 10);
        if (s != endp && *endp == '\0') {
                *val = l;
                return 0;
        } else
                return -1;
}

void *safe_malloc(size_t size)
{
        void *p;
        if ((p = malloc(size)) == NULL) {
                fprintf(stderr, "Out of memory, failed to allocate %zd bytes\n",
                        size);
                exit(1);
        }

        return p;
}

void usage(char *argv0)
{
  fprintf(stderr, "Usage: %s thread_count array-size\n\n", argv0);
  exit(1);
}

/*
 * This function computes a line of output
 * as an array of x_char color values.
 */
void compute_mandel_line(int line, int color_val[])
{
        /*
         * x and y traverse the complex plane.
         */
        double x, y;

        int n;
        int val;

        /* Find out the y value corresponding to this line */
        y = ymax - ystep * line;

        /* and iterate for all points on this line */
        for (x = xmin, n = 0; n < x_chars; x+= xstep, n++) {

                /* Compute the point's color value */
                val = mandel_iterations_at_point(x, y, MANDEL_MAX_ITERATION);
                if (val > 255)
                        val = 255;

                /* And store it in the color_val[] array */
                val = xterm_color(val);
                color_val[n] = val;
        }
}

/*
 * This function outputs an array of x_char color values
 * to a 256-color xterm.
 */
void output_mandel_line(int fd, int color_val[])
{
        int i;
        char point ='@';
        char newline='\n';

        for (i = 0; i < x_chars; i++) {
                /* Set the current color, then output the point */
                set_xterm_color(fd, color_val[i]);
                if (write(fd, &point, 1) != 1) {
                        perror("compute_and_output_mandel_line: write point");
                        exit(1);
                }
        }

        /* Now that the line is done, output a newline character */
        if (write(fd, &newline, 1) != 1) {
                perror("compute_and_output_mandel_line: write newline");
                exit(1);
        }
}

void compute_and_output_mandel_line(int fd, int line)
{
        /*
         * A temporary array, used to hold color values for the line being drawn
         */
        int color_val[x_chars];

        compute_mandel_line(line, color_val);
        output_mandel_line(fd, color_val);
}

/*
 * Create a shared memory area, usable by all descendants of the calling
 * process.
 */
void *create_shared_memory_area(unsigned int numbytes)
{
        int pages;
        void *addr;

        if (numbytes == 0) {
                fprintf(stderr, "%s: internal error: called for numbytes == 0\n", __func__);
                exit(1);
        }

        /*
         * Determine the number of pages needed, round up the requested number of
         * pages
         */
        pages = (numbytes - 1) / sysconf(_SC_PAGE_SIZE) + 1;

        /* Create a shared, anonymous mapping for this number of pages */
        /* TODO:
                addr = mmap(...)
        */
        addr = mmap(NULL, pages, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1,0);

        return addr;
}

void destroy_shared_memory_area(void *addr, unsigned int numbytes) {
        int pages;

        if (numbytes == 0) {
                fprintf(stderr, "%s: internal error: called for numbytes == 0\n", __func__);
                exit(1);
        }

        /*
         * Determine the number of pages needed, round up the requested number of
         * pages
         */
        pages = (numbytes - 1) / sysconf(_SC_PAGE_SIZE) + 1;

        if (munmap(addr, pages * sysconf(_SC_PAGE_SIZE)) == -1) {
                perror("destroy_shared_memory_area: munmap failed");
                exit(1);
        }
}

/* Start function for each thread */
void *thread_execute(int line, int procnt)
{
        int line_num;
        int color_val[x_chars];
        for (line_num=line ; line_num<y_chars; line_num+=procnt) {
                compute_mandel_line(line_num, color_val);
                sem_wait(&sem_array[line]);
                output_mandel_line(1, color_val);
                sem_post(&sem_array[(line_num+1) % procnt]);
        }

        return NULL;
}

int main(int argc, char *argv[])
{
        int i, procnt, status;

        xstep = (xmax - xmin) / x_chars;
        ystep = (ymax - ymin) / y_chars;

        signal(SIGINT, handler);
        if (argc != 2)
                usage(argv[0]);
        if (safe_atoi(argv[1], &procnt) < 0 || procnt <= 0) {
                fprintf(stderr, "`%s' is not valid for `thread_count'\n", argv[1]);
                exit(1);
        }

        // CREATE SEMAPHORES (ONE FOR EACH PROCESS)
        sem_array = create_shared_memory_area(procnt * sizeof(sem_t));
        for (i=0; i<procnt; i++) {
                sem_init(&sem_array[i],1,0); //sem_init has pshared=1 so it can be shared in mmap
        }

        // INITIALIZE FIRST SEMAPHORE
        sem_post(&sem_array[0]);

        // CREATE FORKS (PROCESSES)
        pid_t child_pid[procnt];
        for (i=0 ; i<procnt ; i++) {
                pid_t b = fork();
                child_pid[i] = b;
                if (b < 0) {
                        perror("error with creation of child");
                        exit(1);
                }
                if (b == 0) {
                        thread_execute(i, procnt);
                        exit(1);
                }
        }
        for (i=0; i<procnt ; i++) {
                child_pid[i] = wait(&status);
        }

        for (i=0; i<procnt ; i++) {
              sem_destroy(&sem_array[i]);
      }

        destroy_shared_memory_area(sem_array, procnt * sizeof(sem_t));
        reset_xterm_color(1);
        return 0;
}
