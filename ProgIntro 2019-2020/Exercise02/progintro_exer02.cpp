#include <iostream>

using namespace std;

int main() {
  int m,n;
  int x,y;
  cin >> m;
  cin >> n;
  cin >> x;
  cin >> y;
  int w = y*m + x*n;
  int z = y*n;
  cout << w << " " << z;
}
