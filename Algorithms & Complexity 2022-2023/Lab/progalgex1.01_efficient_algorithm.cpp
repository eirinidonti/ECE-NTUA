//Efficient algorithm implemented with binary search algorithm.
//Reduce time complexity by checking quickly if it exists segment
//of length at least K having sum >= 0.
#include <iostream>
#include <limits.h>
#include <math.h>

using namespace std;

bool possible(int a[], int k, int n, int med){ //Check if median is possible.
    int arr[n];                                //array with length n
    for(int j = 0; j < n; j++){
      if(a[j] < med) {arr[j] = -1;} // if j-th index of array a[] is < med, then store -1 in array arr[]
      else {arr[j] = 1;}            // else store 1 in array arr[].

      if(j != 0) {arr[j] += arr[j - 1];} // calculate prefix sum of array arr[].
    }

    int minimum_prefix = 0;                 // minimum prefix
    int maximum_sum_of_subarray = arr[k-1]; // maximum sum of subarray having length at least k.
    // check if array arr[] has segment of length at least k with positive sum.
    for(int i = k; i < n; i++) {                         //in i-th thesis
      minimum_prefix = min(minimum_prefix, arr[i - k]); //check if prefix sum (in positions 0, 1, ..., i-k) is minimum
      maximum_sum_of_subarray = max(maximum_sum_of_subarray, arr[i] - minimum_prefix); // store maximum sum of subarray having length at least k.
    }

    if(maximum_sum_of_subarray <= 0) {return false;} // if [maximum sum of subarray having length at least k] < 0, then return false.
    return true;                                     // else return true.
}

int median(int a[], int k, int n){ // calculate maximum median of subarray with length at least k.

    int left =1;         //left tracking
    int right = n + 1;   // right tracking
    int max_median = -1; // maximum median tracking
    while(left <= right){
       int m = (left + right)/2;  //calculate middle thesis of subarray
       if(!possible(a, k, n, m)){ //if it is not possible median
          right = m - 1;          // move right track at the thesis (median - 1).
       }
       else {
          max_median = m;        // if it is possible, median is candidate for maximum median.
          left = m + 1;          // move left track at the thesis (median + 1).
       }
    }
    return max_median;          // after searching, return maximum median.
}

int main(int argc, char **argv){
  int N, K;
  cin >> N; //Read from input
  cin >> K;

  int c[N]; // packages
  for(int i = 0; i < N; i++){ //Read from input
    cin >> c[i];
  }

  int res = median(c, K, N) ; // Call function to calculate median of sequence (K numbers)
  cout << res << endl; //Print result
  return 0;
}
