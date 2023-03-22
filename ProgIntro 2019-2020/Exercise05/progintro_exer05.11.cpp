#include <stdio.h>

int main() {
    int n, i, j, row_sum, col_sum, diag1_sum = 0, diag2_sum = 0;
    scanf("%d", &n);
    int square[n][n];

    // Read input matrix
    for(i = 0; i < n; i++) {
        for(j = 0; j < n; j++) {
            scanf("%d", &square[i][j]);
        }
    }

    // Calculate expected sum of each row, column, and diagonal

    // Check rows and columns
    for(i = 0; i < n; i++) {
        row_sum = col_sum = 0;
        for(j = 0; j < n; j++) {
            row_sum += square[i][j];
            col_sum += square[j][i];
        }
        if(row_sum != col_sum) {
            printf("no\n");
            return 0;
        }
    }
    int expected_sum = row_sum; //or col_sum
    // Check diagonals
    for(i = 0; i < n; i++) {
        diag1_sum += square[i][i];
        diag2_sum += square[i][n - 1 - i];
    }
    if(diag1_sum != expected_sum || diag2_sum != expected_sum) {
        printf("no\n");
        return 0;
    }

    printf("yes\n");
    return 0;
}
