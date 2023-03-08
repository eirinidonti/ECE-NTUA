#include <iostream>
#include <bits/stdc++.h>
#include <limits.h>
#include <math.h>
using namespace std;

int median(int a[], int k, int n){
  int array[n];
  int m = 0;
  int ck = k;
  int med;
    for(int w = 0; w < n; w++){            //For every supermarket
        for(int j=0; j<= n-ck; j++){       //For every subsequence of supermarkets
            for(int i = w; i < ck+j; i++){ //with length K = (ck + j - w) <= n
              array[i] = a[i];
              //cout << array[i] << " ";//
            }
            //cout << endl;
            sort(array+w, array+ck+j);    // sort subarray with length (ck + j - w)
            /*cout<< "sort array" << endl;
              for(int i = w; i < ck+j; i++){
                cout << array[i] << " ";
              }
              cout << endl;*/
            int count_k = ck + j - w;    // K of each subarray is K = (ck + j - w)
            if(count_k%2 != 0){                  // if length K is odd, med is equal to the
               med = array[w+(count_k +1)/2 -1]; // content of thesis (subarray of array)
            }                           //[(length + 1)/2 -1] e.g. 1 2 3 => subarray[(3+1)/2 -1] = 2
            else{                                // if length K is even, med is equal to the
              med = array[w + (count_k)/2 -1];   // content of thesis (subarray of array)
            }                          //[(length)/2 -1] e.g. 1 2 3 4 => subarray[(4)/2 -1] = 2
            //cout << "med =" << med << endl;
            if(m < med){                        // select the max median of all subsequences
              m = med;
            }
            //cout << m << endl;
        }
        ck++; // equals to length++
    }
    return m;
}

int main(int argc, char **argv){
  int N, K;
  cin >> N; //Read from input
  cin >> K;

  int c[N]; // packages
  for(int i = 0; i < N; i++){ //Read from input
    cin >> c[i];
  }

  int res =  median(c, K, N); // Call function to calculate median of sequence (K numbers)
  cout << res << endl; //Print result
  return 0;
}
