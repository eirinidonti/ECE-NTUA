#include <iostream>
#include <limits>

using namespace std;

int main() {
    int N, M;
    cin >> N >> M;

    int matrix[N][M];

    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < M; ++j) {
           cin >> matrix[i][j];
        }
    }

    int count_max_col = 0;
    for (int j = 0; j < M; ++j) {
        int max_col = numeric_limits<int>::min();
        for (int i = 0; i < N; ++i) {
            max_col = max(max_col, matrix[i][j]);
        }
        //cout << min(max_col, numeric_limits<int>::max()) << " ";

        for (int i = 0; i < N; ++i) {
            if (matrix[i][j] == max_col) {
                ++count_max_col;
            }
        }
    }
    //cout << endl;
    cout << count_max_col << endl;

    int count_min_row = 0;
    for (int i = 0; i < N; ++i) {
        int min_row = numeric_limits<int>::max();
        for (int j = 0; j < M; ++j) {
            min_row = min(min_row, matrix[i][j]);
        }

        //cout << max(min_row, numeric_limits<int>::min()) << " ";

        for (int j = 0; j < M; ++j) {
            if (matrix[i][j] == min_row) {
                ++count_min_row;
            }
        }
    }
    //cout << endl;
    cout << count_min_row << endl;

    return 0;
}
