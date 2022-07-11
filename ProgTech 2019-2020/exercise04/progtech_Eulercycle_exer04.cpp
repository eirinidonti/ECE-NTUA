#include <iostream>

using namespace std;

int main() {
    int N, M;
    int u, v;

    cin >> N;
    cin >> M;

    bool a[N];
    for (int k=0; k < N; k++){
       a[k]= true;
    }

    for (int i = 0; i < M; i++) {
      cin >> u;
      if(a[u] == true) {
         a[u] = false;
      }
      else {
        a[u] = true;
      }
      cin >> v;
      if(a[v] == true) {
         a[v] = false;
      }
      else {
        a[v] = true;
      }
    }
    int even = 0;
    int odd = 0;
    int odd1;
    int odd2;
    for (int h = 0; h< N; h++) {
       if(a[h] == true){
          even++;
        }
        else {
          odd++;
          if(odd == 1) {
            odd1 = h;
          }
          else if(odd == 2) {
            odd2 = h;
          }
          else{
             break;
          }
        }
      }
      if (N == even) {
         cout << "CYCLE" << endl;
      }
      else if (odd == 2 || odd == 1) {
        cout << "PATH" << odd1;
        if(odd == 2) {
           cout <<" "<< odd2 << endl;
         }
       }
       else {
         cout << "IMPOSSIBLE" <<endl;
       }
       return 0;
}
