#include <iostream>
#include <cmath>

using namespace std;

int sum_of_powers(int num, int power) {
    int sum = 0;
    while (num > 0) {
        int digit = num % 10;
        sum += pow(digit, power);
        num /= 10;
    }
    return sum;
}

int main() {
    int N;
    cin >> N;

    for (int i = 0; i <= 99999999; i++) {
        if (sum_of_powers(i, N) == i) {
            cout << i << endl;
        }
    }

    return 0;
}
