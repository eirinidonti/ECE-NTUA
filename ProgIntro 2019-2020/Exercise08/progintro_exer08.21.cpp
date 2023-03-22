 #include <cstdio>
 #include <stdlib.h>
 #include <iostream>
 #include <algorithm>

 using namespace std;

class bstree {
  private:
      struct Node {
          int value;
          Node* left;
          Node* right;
          Node(int val) : value(val), left(nullptr), right(nullptr) {}
      };

      Node* root;

      void destroy_tree(Node* node) {
          if (node != nullptr) {
              destroy_tree(node->left);
              destroy_tree(node->right);
              delete node;
          }
      }

      void insert(Node*& node, int x) {
          if (node == nullptr) {
              node = new Node(x);
          }
          else if (x < node->value) {
              insert(node->left, x);
          }
          else if (x > node->value) {
              insert(node->right, x);
          }
      }

      int search(Node* node, int x, int level) {
          if (node == nullptr) {
              return 0;
          }
          else if (x == node->value) {
              return level;
          }
          else if (x < node->value) {
              return search(node->left, x, level+1);
          }
          else {
              return search(node->right, x, level+1);
          }
      }

      int height_helper(Node* node) {
          if (node == nullptr) {
              return 0;
          } else {
              int left_height = height_helper(node->left);
              int right_height = height_helper(node->right);
              return 1 + std::max(left_height, right_height);
          }
      }

      Node* find_min(Node* node) {
          while (node->left != nullptr) {
              node = node->left;
          }
          return node;
      }

      Node* find_max(Node* node) {
          while (node->right != nullptr) {
              node = node->right;
          }
          return node;
      }

      void inorder_traversal(Node* node) {
          if (node != nullptr) {
              inorder_traversal(node->left);
              std::cout << node->value << " ";
              inorder_traversal(node->right);
          }
      }

      void preorder_traversal(Node* node) {
          if (node != nullptr) {
              std::cout << node->value << " ";
              preorder_traversal(node->left);
              preorder_traversal(node->right);
          }
      }

      void postorder_traversal(Node* node) {
          if (node != nullptr) {
              postorder_traversal(node->left);
              postorder_traversal(node->right);
              std::cout << node->value << " ";
          }
      }

  public:
      bstree() : root(nullptr) {}

      ~bstree() {
          destroy_tree(root);
      }

      int height() {
          return height_helper(root);
      }

      void insert(int x) {
          insert(root, x);
      }

      int search(int x) {
          return search(root, x, 1);
      }

      int min() {
          return find_min(root)->value;
      }

      int max() {
          return find_max(root)->value;
      }

      void inorder() {
          inorder_traversal(root);
      }

      void preorder() {
          preorder_traversal(root);
      }

      void postorder() {
          postorder_traversal(root);
      }
};

int main() {
  bstree b;
  int N;
  cin >> N;
  for(int i=0; i<N; i++){
    int n;
    cin >> n;
    b.insert(n);
  }
  int M;
  cin >> M;
  int a[M];
  for(int j=0; j<M; j++){
    cin >> a[j];
  }
  cout << b.height() <<endl; //
  cout << b.min() <<" "<< b.max() << endl;

  for(int j=0; j<M; j++){
    cout << b.search(a[j]) << " ";
  }
  cout << endl;
  b.inorder();
  cout << "end" << endl;
  b.preorder();
  cout << "end" << endl;
  b.postorder();
  cout << "end" << endl;

  return 0;
}
