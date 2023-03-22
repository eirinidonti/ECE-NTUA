#include <iostream>
#include <iomanip> // για το setprecision

using namespace std;

int main() {
    int N, M;
    cin >> N >> M;

    double matrix[N][M];

    // διάβασμα των στοιχείων του πίνακα
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < M; ++j) {
           cin >> matrix[i][j];
        }
    }

    double av1 = 0;
    // υπολογισμός των μέσων όρων των γραμμών
    for (int i = 0; i < N; ++i) {
        double sum = 0;
        for (int j = 0; j < M; ++j) {
            sum += matrix[i][j];
        }
        double average = sum / M;
        av1 += average;
        //cout << fixed << setprecision(3) << average << " ";
    }
    cout << fixed << setprecision(3) << av1/N << " " << endl;
    //cout << endl;


    double av2 = 0;
    // υπολογισμός των μέσων όρων των στηλών
    for (int j = 0; j < M; ++j) {
        double sum = 0;
        for (int i = 0; i < N; ++i) {
            sum += matrix[i][j];
        }
        double average = sum / N;
        av2+=average;
        //cout << fixed << setprecision(3) << average << " ";
    }
    //cout << endl;
    cout << fixed << setprecision(3) << av2/M << " " << endl;

    return 0;
}
