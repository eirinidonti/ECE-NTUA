#include <stdio.h>
#include <iostream>
#include <cstring>
#include <limits.h>
#define maxN = 20000;
#define maxK = 1000000;

using namespace std;

int main(int argc, char **argv){
      int N;    //number of  appartments
      int K;    //sum of residents
      cin >> N; //Read from input.
      cin >> K;

      int p[N]; //sum of residents in each appartment

      for(int i=0; i<N; i++){ //Read from input.
        cin >> p[i];
      }

      int res = -1; //Initialize result with -1.
      int previous[N];
      int lsum[K+1];

      for(int i=0; i<=K; i++){ //Initialize lsum[] with -1 value.
        lsum[i] = -1;
      }

      for(int i=0; i<N; i++){
          if(p[i] == K){       //if  p[i] = K, then result equals to 1
            cout << 1 << endl;
            return 0;
          }
      }

      int c = 0; // Compute first c (<N) that p[c] <= K.
      while(c < N && p[c] > K) {++c;}

      if(c == N){             //if there are no c that p[c] <= K.
          cout << -1 << endl; //print -1 value.
          return 0;
      }

      int counter = 0;
      int sumprevious[N]; //store previous sum
      int lengthprevious[N];//store previous length
      for(int j=0; j<N; j++){ // Initialize sumprevious[] and lengthprevious[] array with zero value
        sumprevious[j] = 0;
        lengthprevious[j] = 0;
      }

      for(int i = c; i < N; i++){ //from the first thesis that p[c] <= K.
          int sum = 0;

          for(int w = i; w < N; w++){   //for every subarray
            sum += p[w];                //find sum of p[] array till w thesis.
            if(sum <= K) {              // if sum <= K
                if(lsum[K-sum] != -1){  //if lsum[K-sum] is not editted
                  int currentlength = lsum[K-sum]+w-i+1;
                  if(res == -1 || currentlength < res) {res = currentlength;} // if result res is not editted or
                }                                                                         // the length till this position [previous length + w-i+1 (new length)] is < res
            } else {break;}         //move to another subarray                            // then store new length in variable res
          }

          if(p[i] > K) {break;}

           for(int y = counter; y <=i; y++){  //if p[i] <= K

               int sum = sumprevious[N-y-1] + p[i]; //find sum till thesis i
               int length = lengthprevious[N-y-1] +1; // find length till thesis i

              if(sum <= K) {
                sumprevious[N-y-1] = sum;            //store current sum and length
                lengthprevious[N-y-1] = length;

                if(lsum[sum] == -1 || length < lsum[sum]){ //if length is not editted or length is less than current length
                  lsum[sum] = length;                      //then store current length.
                }
              }
              else{ //if sum > K, then move to another subarray
                  counter++;
                }
              }
          }

      cout << res << endl; //Print output.
      return 0;
}
