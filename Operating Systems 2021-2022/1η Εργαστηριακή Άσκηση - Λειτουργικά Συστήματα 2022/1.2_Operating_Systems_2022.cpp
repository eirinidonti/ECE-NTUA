#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

void doWrite(int fd, const char *buff, int len) {
  ssize_t wcnt;
  size_t idx;
  wcnt = 0;
  idx = 0;

  do{
    wcnt = write(fd, buff + idx, len - tdx);
    if(wcnt == -1) {
      perror("write");
      return;
    }
     idx += wcnt;

  } while(idx < len);

}

void write_file(int fd, const char *infile){

  char buff[1024];
  ssize_t rcnt;

  ssize_t open_fd = open(infile, O_RDONLY);

  if(open_fd == -1){
     perror("open");
     exit(1);
  }
  for(;;){
        rcnt = read(open_fd, buff, sizeof(buff)-1);
        if(rcnt == 0){
            return;
        }
        if(rcnt == -1){ /*error*/
          perror("read");
          return;
        }
        doWrite(fd, buff, rcnt);
  }
  close(open_fd);
}

int main(int argc, char **argv) {
       if(argc <3 || argc >4) { /* if no suitable arguments */
          printf("Usage: ./fconc infile1 infile2 [outfile (default:fconc.out)]");
       }
       else if(argc>=3 && argc<=4){

          int exit_fd, oflags, mode;
          oflags=O_CREAT|O_WRONLY|O_TRUNC;
          mode = S_IRUSR | S_IWUSR;
          if(argc == 3) { //if .out exists
            exit_fd = open("fconc.out", oflags, mode);
          }
      }
      else { //if .out doesn't exist
        exit_fd= open(argv[3], oflags, mode);
      }

      if(exit fd == -1){
         perror("open");
         exit(1);
     }
     else {
       write_file(exit_fd, argv[1]);
       write_file(exit_fd, argv[2]);
     }
     close(exit_fd);
     return 0;
}
