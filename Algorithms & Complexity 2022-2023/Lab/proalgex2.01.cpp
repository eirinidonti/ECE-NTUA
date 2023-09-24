#include <stdio.h>
#include <iostream>
#include <cstring>
#include <limits.h>
#include <bits/stdc++.h>
#define maxN = 200000;
#define maxK = 1000000000;

using namespace std;

int K;

//find first bigger element from value val
int bigger_element(vector<int>& v, int left, int right, int val) {
  while (right - left > 1) {
    int r = left + (right - left) / 2;
    if (v[r] >= val) {right = r;}
    else {left = r;}
  }

  return right;
}

//find next first smaller element from value val
int smaller_element(vector<int>& v, int left, int right, int val) {
  int c = -1;
  while (left <= right) {
    int r = (left + right) / 2;
    if (v[r] == val) {return r;}
    if (v[r] >= val) {left = r + 1;}
    else {
      c = r;
      right = r - 1;
    }
  }
  return c;
}

//find longest increasing sequence
int longest_increasing_subsequence(vector<int> &v){
    if (v.size() == 0) return 0;
    //initialize tail for increasing sequence
    vector<int> tail(v.size(), 0);
    int maxi = INT_MIN;
    //1: latest edit, 2: max length till this point
    vector<vector<int> > tailforwardmaxnum(v.size(), vector<int>(2, maxi));
    vector<vector<int> > tailforwardmaxlen(v.size(), vector<int>(2, maxi));

    //length of first element
    int lengthfor = 1;

    // initialize first position with 1st element
    tail[0] = v[0];
    tailforwardmaxnum[0][0] = v[0];
    tailforwardmaxnum[0][1] = v[0];
    tailforwardmaxlen[0][0] = lengthfor;
    tailforwardmaxlen[0][1] = lengthfor;

    // find longest increasing sequence
    for (int i = 1; i < v.size(); i++) {
      // if v[i] is smaller than tail[0] replace it
      if (v[i] < tail[0]) {
        tail[0] = v[i];

        tailforwardmaxnum[i][0] = v[i];
        tailforwardmaxlen[i][0] = 1;
      } else if (v[i] > tail[lengthfor - 1]) { // v[i] extends largest subsequence
        tail[lengthfor++] = v[i];

        tailforwardmaxnum[i][0] = v[i];
        tailforwardmaxlen[i][0] = lengthfor;
      } else {  // find if we can reduce tail
        int forpos = bigger_element(tail, -1, lengthfor - 1, v[i]);

        tail[forpos] = v[i];

        tailforwardmaxnum[i][0] = v[i];
        tailforwardmaxlen[i][0] = forpos + 1;
      }

      // tail for maximum length
      tailforwardmaxnum[i][1] = tail[lengthfor - 1];
      // max length
      tailforwardmaxlen[i][1] = lengthfor;
    }

     int maxforward = lengthfor;

     //1: latest edit, 2: max length till this point
     vector<vector<int> > tailbackwardmaxnum(v.size(), vector<int>(2, maxi));
     vector<vector<int> > tailbackwardmaxlen(v.size(), vector<int>(2, maxi));

     //length of first element
     int lengthback = 1;

    // initialize endtail for decreasing sequence
    vector<int> endtail(v.size(), 0);

    // initialize first position with (N-1)th element
    endtail[0] = v[v.size() - 1] + K;
    tailbackwardmaxnum[0][0] = endtail[0];
    tailbackwardmaxnum[0][1] = endtail[0];
    tailbackwardmaxlen[0][0] = lengthback;
    tailbackwardmaxlen[0][1] = lengthback;

    // find longest decreasing sequence (from N-2)
    for (int i = v.size() - 2; i != -1; i--) {
      // if v[i] is bigger than tail[0] replace it
      if (v[i] + K > endtail[0]) {
        endtail[0] = v[i] + K;

        tailbackwardmaxnum[v.size() - 1 - i][0] = v[i] + K;
        tailbackwardmaxlen[v.size() - 1 - i][0] = 1;
      } else if (v[i] + K < endtail[lengthback - 1]) { // v[i] extends largest subsequence
        endtail[lengthback++] = v[i] + K;

        tailbackwardmaxnum[v.size() - 1 - i][0] = v[i] + K;
        tailbackwardmaxlen[v.size() - 1 - i][0] = lengthback;
      } else { // find if we can increase tail
        int backpos = smaller_element(endtail, 0, lengthback, v[i] + K);

        endtail[backpos] = v[i] + K;

        tailbackwardmaxnum[v.size() - 1 - i][0] = v[i] + K;
        tailbackwardmaxlen[v.size() - 1 - i][0] = backpos + 1;
      }

      tailbackwardmaxnum[v.size() - 1 - i][1] = endtail[lengthback - 1];
      tailbackwardmaxlen[v.size() - 1 - i][1] = lengthback;
    }

    int max = INT_MIN;
    int r = 0;
    int forw_max = 0;
    int forw = 0;
    int backw_max = 0;
    int backw = 0;

    for (int k = 0; k < v.size() - 1; k++) {
      forw = tailforwardmaxnum[k][0];
      backw = tailbackwardmaxnum[v.size() - k - 2][0];

      forw_max = tailforwardmaxnum[k][1];
      backw_max = tailbackwardmaxnum[v.size() - k - 2][1];

      // check if exists increasing sequence
      if (forw < backw) {
        r = tailforwardmaxlen[k][0] + tailbackwardmaxlen[v.size() - k - 2][0];
        if (r > max) {
          max = r;
        }
      }
      r = 0;

      // check if exists increasing sequence
      if (forw_max < backw_max) {
        r = tailforwardmaxlen[k][1] + tailbackwardmaxlen[v.size() - k - 2][1];
        if (r > max) {
          max = r;
        }
      }
      r = 0;
    }

    if (maxforward > max) {return maxforward;}

    return max;
  }

int main(int argc, char **argv){
      int N;
      cin >> N; //Read from input.
      cin >> K;

      vector<int> vectorp;
      vectorp.resize(N,0);

      for(int i=0; i<N; i++){ //Read from input.
        cin >> vectorp[i];
      }

      int res = longest_increasing_subsequence(vectorp);

      cout << res << endl; //Print output.
      return 0;
}
