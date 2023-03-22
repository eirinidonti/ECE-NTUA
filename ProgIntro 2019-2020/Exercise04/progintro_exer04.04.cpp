#include <iostream>
#include <cmath>

using namespace std;

int main() {
    int digit_sum, num;
    for (int i = 1000; i < 10000; i++) {
        digit_sum = pow(i%10, 4) + pow((i/10)%10, 4) + pow((i/100)%10, 4) + pow(i/1000, 4);
        if (digit_sum == i) {
            cout << i << endl;
        }
    }
    return 0;
}
