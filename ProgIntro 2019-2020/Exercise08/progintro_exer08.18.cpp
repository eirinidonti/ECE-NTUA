#include <cstdio>
#include <iostream>
#include <stdlib.h>

using namespace std;

class queue {
    public:
      queue ();
      bool empty ();
      void enqueue (int x);
      int dequeue ();
      int peek ();
    private:
      struct node {
        int info;
        node *next;
        node *previous;
      };
      node *front, *rear;
};

queue::queue () {
  front = rear = nullptr;
}

bool queue::empty () {
  return front == nullptr;
}

void queue::enqueue (int x) {
  node *p = new node;
  p ->info = x;
  p ->next = nullptr;
  if(front == nullptr) front = p;
  else rear->next = p;
  rear = p;
}

int queue::dequeue (){
  node *p = front;
  int result = front->info;
  if(front == rear) rear = nullptr;
  front = front->next;
  delete p;
  return result;
}

int queue::peek () {
  return front -> info;
}

int main() {
  int y;
  queue th;
  queue a;
  int the = 0;
  int ar = 0;

  while(scanf("%d",&y) == 1){
    if(y>0){
      th.enqueue(y);
      the++;
    }
    else{
      a.enqueue(y);
      ar++;
    }
  }

  if(the == ar){
    for(int i=0; i<the; i++){
      if(th.peek() != abs(a.peek())) {
        cout << "no\n";
        return 0;
      }
      else{
        th.dequeue();
        a.dequeue();
      }
    }
  }
  else{
    cout << "no\n";
    return 0;
  }

  cout << "yes\n";
  return 0;
}
