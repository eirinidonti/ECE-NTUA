#include <iostream>

using namespace std;

int main() {
    int n;
    cin >> n;

    int last_digit = (n / 10) % 10;
    cout << last_digit << endl;

    return 0;
}
