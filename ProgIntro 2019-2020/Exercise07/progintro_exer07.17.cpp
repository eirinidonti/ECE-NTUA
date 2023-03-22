#include <iostream>

using namespace std;

int main() {
    unsigned long long N;
    cin >> N;

    unsigned long long factorial = 1;
    unsigned long long max_number = 1;

    for (unsigned long long i = 1; factorial <= N; i++) {
        max_number = i;
        factorial *= i;
    }

    cout << max_number - 1 << endl;

    return 0;
}
