#include <iostream>
#include <cstdlib>
#include <cmath>

using namespace std;

int gcd(int a, int b) {
    if (b == 0) {
        return a;
    } else {
        return gcd(b, a % b);
    }
}

void reduce(int& numerator, int& denominator) {
    int divisor = gcd(numerator, denominator);
    numerator /= divisor;
    denominator /= divisor;
}

void printMixedFraction(int whole, int numerator, int denominator) {

  if((numerator >= 0 && denominator >= 0) || (numerator < 0 && denominator < 0)){
        cout << whole << " " << abs(numerator) << " " << abs(denominator) << endl;
  }
  else if((numerator > 0 && denominator < 0) || (numerator < 0 && denominator > 0)){
        cout << "-" << abs(whole) << " " << abs(numerator) << " " << abs(denominator) << endl;
  }

}

int main() {
    int N;
    cin >> N;

    for (int i = 0; i < N; i++) {
        char op;
        int num1, den1, num2, den2;
        cin >> op >> num1 >> den1 >> num2 >> den2;

        // Check for invalid input
        if (den1 == 0 || den2 == 0) {
            cout << "error" << endl;
            continue;
        } else if (op == '/' && num2 == 0) {
            cout << "error" << endl;
            continue;
        }

        // Perform the operation
        int result_num, result_den;
        switch (op) {
            case '+':
                result_num = num1 * den2 + num2 * den1;
                result_den = den1 * den2;
                break;
            case '-':
                result_num = num1 * den2 - num2 * den1;
                result_den = den1 * den2;
                break;
            case '*':
                result_num = num1 * num2;
                result_den = den1 * den2;
                break;
            case '/':
                result_num = num1 * den2;
                result_den = den1 * num2;
                break;
        }

        // Simplify the result
        reduce(result_num, result_den);

        // Convert to mixed fraction format
        int whole = result_num / result_den;
        int numerator = result_num % result_den;
        int denominator = result_den;

        // Output the result
        printMixedFraction(whole, numerator, denominator);
    }

    return 0;
}
