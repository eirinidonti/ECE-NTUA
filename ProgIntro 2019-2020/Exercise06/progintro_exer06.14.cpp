#include <iostream>
#include <bits/stdc++.h>
#include <climits>

using namespace std;

int main() {
   int n;
   cin >> n;
   int ar1[n];
   int ar2[n];
   int orar1[n];
   int orar2[n];
   int mindif;
   int maxdif;
   bool flag = false;
   for(int i=0; i<n; i++){
     cin >> ar1[i];
     orar1[i] = ar1[i];
   }

   sort(ar1, ar1 + n);

   for(int i=0; i<n; i++){
     cin >> ar2[i];
     orar2[i] = ar1[i];
   }

   sort(ar2, ar2 + n);

   for(int i=0; i<n; i++){
     if(ar1[i] != ar2[i]){
       flag = true;
     }
   }

maxdif = INT_MIN;
mindif = INT_MAX;

   if(flag){
     for(int j=0; j<n; j++){
       if(ar1[j] > ar2[j]){
         maxdif = max(maxdif, ar1[j]);
         mindif = min(mindif,ar2[j]);
         break;
       }
       else if(ar1[j] < ar2[j]) {
         maxdif = max(maxdif,ar2[j]);
         mindif = min(mindif,ar1[j]);
         break;
       }
     }

     for(int j=0; j<n; j++){
       if(ar1[n-j-1] > ar2[n-j-1]){
         maxdif = max(maxdif,ar1[n-j-1]);
         mindif = min(mindif,ar2[n-j-1]);
         break;
       }
       else if(ar1[n-j-1] < ar2[n-j-1]) {
         mindif = min(mindif,ar1[n-j-1]);
         maxdif = max(maxdif,ar2[n-j-1]);
         break;
       }
     }

     cout << "no" << " " << mindif <<" "<< maxdif << endl;
   }else{
     cout << "yes\n";
   }
   return 0;

}
