 #include <iostream>

 using namespace std;

 template <typename T>
 class stack {
  public:
     stack (int size) {
       top = 0;
       mysize = size;
       a = new T[mysize];
     }

     stack (const stack &s) {
       int h;
       a = new T[s.mysize];
       mysize = s.mysize;
       top = s.top;
       for(h = 0; h < s.top; h++)
        a[h] = s.a[h];
     }

    ~stack () {
      delete [] a;
    }

    const stack & operator = (const stack &s) {
      delete [] a;
      a = new T[s.mysize];
      mysize = s.mysize;
      top = s.top;
      for(int i = 0; i < s.top; i++){
        a[i] = s.a[i];
      }
      return *this;
    }

    bool empty () {
      if(top == 0){
        return true;
      }
      else {
        return false;
      }
    }

    void push (const T &x) {
      a[top++] = x;
    }

    T pop () {
      return a[--top];
    }

    int size () {
      return top;
    }

    friend ostream & operator << (ostream &out, const stack &s) {
      if(s.top == 0){
        cout << "[]";
      }
      else{
        out << "[";
        for(int i = 0; i < s.top-1; i++){
          out << s.a[i] << ",";
        }
        out << s.a[s.top-1] << "]";
      }
      return out;
    }

 private:
   int mysize;
   T *a;
   int top;
};
