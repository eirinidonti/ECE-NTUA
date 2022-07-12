#include <algorithm>

using namespace std;

template <typename T>
struct node {
  T data;
  node *left, *right;
};

template <typename T>
int traverse(node<T> *t, int &count){
  if(t == nullptr){
    return 0;
  }
  int lh = traverse(t->left,count);
  int rh = traverse(t->right, count);
  if(lh > rh) {
    count++;
  }
  return 1 + max(lh,rh);
}

template <typename T>
int countLH(node<T> *root){
  int result;
  traverse(root,result);
  return result;
}
