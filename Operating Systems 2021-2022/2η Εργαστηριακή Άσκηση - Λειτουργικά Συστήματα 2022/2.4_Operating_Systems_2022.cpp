#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/wait.h>
#include "tree.h"
#include "proc-common.h"

/* help from given pipe-example.c*/

char calculator (char symbol, char a_char, char b_char){
    int a = a_char - '0'; int b = b_char - '0';
    switch (symbol){
      case '+': {
          printf("The calculation of %i", a);
          printf(" + %i", b);
          printf(" is equal to %i\n", a + b);
          return a+b+'0';
      }
      case '*': {
          printf("The calculation of %i", a);
          printf(" * %i", b);
          printf(" is equal to %i\n", a*b);
          return a*b + '0';
      }
   }
  return -1;
}

void fork_procs(struct tree_node *root, int fd){
   int status; int i;
   if(root == NULL) { // check what happens LT the node ts empty
      printf("We have a problem: The node is empty \n");
      return;
   }
   printf("PID = %ld, name %s, starting...\n", (long)getpid(), root -> name);
   change_pname(root->name); // create the root of the tree 11 if the node has no children if(root->nr_children == 0){ printf("Create Leaf %s\n",root -> name ); // print the name of
   if(root -> nr_children == 0) {
        printf("Create leaf %s\n", root->name);
        raise(SIGSTOP); /// every leaf is ready so the parent gives the
        char value; /*Convert root -> name from a string which represents an integer to an argument with value of type int */
        if(child_pid[i] == 0){
          close(child_pfd[0]);
          fork_procs(root-> children + i, child_pfd[1]);
          exit(1);
        }
   }
    close(child_pfd[1]);
    wait_for_ready_children(root-> nr_children);
    raise(SIGSTOP);
    printf("PID = %ld, name=%s is awake\n", (long)getpid(), root -> name);
    char val[2];
    for (i=0; i< root->nr_children; i++){
       kill(child_pid[i], SIGCONT);
       if(read(child_pfd[0], &val[i], sizeof(val[i])) != sizeof(val[i])) {
            perror("child: read from pipe");
            exit(1);
    }
    printf("Parent: received value %i from the pipe. Will now compute.\n", val[i]);
    child_pid[i] = waitpid(child_pid[i], &status, 0);
    explain_wait_status(child_pid[i], status);
    }
    char computed = calculator(*root -> name, val[0], val[1]);
    if(write(fd, &computed, sizeof(computed)) != sizeof(computed)){
       perror("child: write to pipe");
       exit(1);
    }
    exit(0);
}

int main(int argc, char *argv[]) {
    int pfd[2];
    struct tree_node *root;
    int status; pid_t p;
     if (argc < 2) {
       fprintf(stderr, "Usage: %s <input_tree_file>\n\n", argv[0]);
       exit(1);
    }

    root = get_tree_from_file(argv[1]);
    printf("Parent: Creating pipe...\n");
    if(pipe(pfd) < 0){
      perror("pipe");
      exit(1);
    }
    printf("Parent: Creating child...\n");
    p = fork();
    if(p<0){
        perror("fork");
        exit(1);
    }
    else if(p == 0){
       fork_procs(root, pfd[1]);
       exit(1);
    }
    wait_for_ready_children(1); // now the node is not sleeping, but is waiting for the children to be ready
    show_pstree(p);
    kill(p, SIGCONT);
    p=wait(&status);
    explain_wait_status(p, status);
    printf("Parent: All done, exiting..\n");
    return 0;
}
