#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/wait.h>
#include "proc-common.h"

#define SLEEP_PROC_SEC 10
#define SLEEP_TREE_SEC 3

void fork_procs(void) {
    /* initial process is A.*/
    pid_t pid_B, pid_C, pid_D;
    int status;

    change_pname("A"); /* we create node A */
    printf("Now we have node A...\n" );

    /*A has 2 children, B and C */
    /* We create node B */

    pid_B = fork();
    if(pid_B < 0){
      perror("He have a problem with node B...");
      exit(1);
    }
    else if(pid_B == 0){ /* if node B has at least one child */
       change_pname("B"); /* we create node B */
       printf("Now we have node B...\n");
    /* We create node D */
       pid_D = fork();
       if(pid_D < 0){
         perror("We have a problem with node D...");
         exit(1);
       }
       else if(pid_D == 0){
         change_pname("D"); /* we create node D */
         printf("Now we have node D...\n");
         printf("Node D is sleeping...\n");
         sleep(SLEEP_PROC_SEC); /* node D has no chidren, so D sleeps */
         printf("Node D exits\n");
         exit(13);
      }
      else if(pid D >0){// Check status for the leaf D
          printf("Node B is waiting for status of node D\n");
          pid_D= wait(&status);
          explain_wait_status(pid_D,status);
          printf("Node B exits\n");
          exit(19);
      }
    }
    else if(pid_B>0){
       /*We create node c */
          pid_C = fork();
          if(pid_C < 0){
              perror("We have a problem with node C...");
              exit(1);
          }
          else if(pid_C == 0){
              change_pname("C"); /* we create node C */
              printf("Now we have node C...\n");
              printf("Node C is sleeping...\n");
              sleep(SLEEP_PROC_SEC); /* node c has no chidren, so C sleep */
              printf("Node C exits\n");
              exit(17);
          }
          else if(pid_C >0){ //Node C is the last leaf of the tree
            printf("Node A is waiting for status of node C\n" );
            pid_C = waitpid(-1,&status,0);
            pid_C = waitpid(-1,&status,0); // A must exit at the end after B. So A needs to wait for double time
            explain_wait_status(pid_C, status);
            printf("Node A exists\n" );
            exit(16);
          }
   }
}

int main (void){
    pid_t p;
    int status;
    p=fork();
    if (p < 0) {
     perror("We have a problem with pid...");
     exit(1);
    }
    if (p == 0){
      fork_procs(); /* create the tree process */
      exit(1);
    }
    sleep(SLEEP_TREE_SEC);
    show_pstree(p); /* Print process tree rooted at process with pid p*/

    /* The fork() process needs Walt() process */
    p=wait(&status);
    explain_wait_status(p,status);
    return 0;
}
