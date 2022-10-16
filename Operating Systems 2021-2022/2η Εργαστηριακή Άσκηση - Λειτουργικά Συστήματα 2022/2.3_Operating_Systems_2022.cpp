#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/wait.h>
#include "tree.h"
#include "proc-common.h"

#define SLEEP_PROC_SEC 10
#define SLEEP_TREE_SEC 3

void fork_procs(struct tree_node *root) { // ask2-signals.c

    int status, c; // c is for children
    pid_t p[c]; int i;
    printf("PID = %ld, name %s, starting...\n", (long)getpid(), root->name);
    change_pname(root->name);

    if(root->nr_children == 0){
        raise(SIGSTOP);
        printf("PID = %ld, name = %s is awake\n", (long)getpid(), root->name);
        exit(0);
    }
    else{
        c=root->nr_children;
        for (i=0; i<c; i++){
          p[i] = fork();
          if(p[i] == 0){
            fork_procs(root->children +i);
            exit(0);
          }
          else if(p[i] < 0){
            perror("Error in fork process");
            exit(1);
          }
        }
        wait_for_ready_children(c);
        raise(SIGSTOP); //stop process
        printf("PID = %ld, name = %s is awake\n", (long)getpid(), root->name);
        for (i=0; i<c; i++){
        kill(p[i],SIGCONT);
        }
        P[i] = waitpid(p[i],&status, 0);
        explain_wait_status(p[i],status);
   }
}

int main(int argc, char *argv[]){
      pid_t pid;
      int status;
      struct tree_node *root;
      struct sigaction sa;
      if(sigaction(SIGCHLD, &sa, NULL) < 0){
         perror("sigaction");
         exit(1);
      }
      if (argc < 2){
          fprintf(stderr, "Usage: %s <tree_file>\n", argv[0]);
          exit(1);
      }

      /* Read tree into memory */
      root = get_tree_from_file(argv[1]);
      /* Fork root of process tree */
      pid = fork();
      if (pid < 0) {
         perror("main: fork");
         exit(1);
      }
      if (pid == 0) {
          /* Child */
           fork_procs(root);
           exit(1);
      }

      wait_for_ready_children(1);

      /* for ask2-[fork, tree} */
      /* sleep(SLEEP_TREE_SEC); */

      /* Print the process tree root at pid*/

      show_pstree(pid);

      /* for ask2-signals */
       kill(pid, SIGCONT);

      /* Wait for the root of the process tree to terminate */
      wait(&status);
      pid=waitpid(pid, &status, 0);
      explain_wait_status(pid, status);
      return 0;
}
