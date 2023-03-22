#include <iostream>
#include <string>
#include <iomanip> // για το setprecision

using namespace std;

int main() {
    int n;
    cin >> n;
    cin.ignore(); // ignore the newline character after n
    int palindromecount = 0;
    for (int i = 0; i < n; i++) {
        string s;
        getline(cin, s);

        if (s.empty()) {
            cout << "empty" << endl;
        } else if (s.length() > 20) {
            cout << "error" << endl;
        } else {
            bool is_palindrome = true;

            for (int j = 0; j < s.length() / 2; j++) {
                if (s[j] != s[s.length() - 1 - j]) {
                    is_palindrome = false;
                    break;
                }
            }

            if (is_palindrome) {
                cout << "yes" << endl;
                palindromecount++;
            } else {
                cout << "no" << endl;
            }
        }
    }

    double palindromePercentage = 100.0 * palindromecount / n;
    cout << fixed << setprecision(3) << palindromePercentage << endl;
    return 0;
}
