#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/waιt.h>
#include "tree.h"
#include "proc-common.h"

#define SLEEP_PROC_SEC 10
#define SLEEP_TREE_SEC 3

void fork_procs(struct tree_node *root) {

change_pname(root->name); // create the root of the tree

// if the node has no children
 if(root->nr_children == 0){
   printf("Now we have leaf %s. It is sleeping\n", root->name); //print the name of the leaf
   sleep(SLEEP_PROC_SEC); // now the node is sleeping

int main(int argc, char *argv[]) //tree-example.c
    struct tree_node *root;
    int status;
    pid_t p;
    if (argc != 2) {
    fprintf(stderr, "Usage: %s <input_tree_file>\n\n", argv[0]);
    exit(1);
    }
    root = get_tree_from_file(argv[1]); // insert filename
    print_tree(root);
    p = fork();
    if(p<0){
    perror("Problem with fork\n");
    exit(1);
    }
    else if(p == 0){ fork_procs(root);
    }
    sleep(SLEEP_TREE_SEC);
    show_pstree(p);
    p = wait(&status);
    explain_wait_status(p,status);
    printf("Exit\n");
    return 0;
}
