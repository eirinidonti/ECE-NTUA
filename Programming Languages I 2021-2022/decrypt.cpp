#include <cstring>
#include <iostream>
#include <algorithm>
#include <cctype>
#include <fstream>
#include <climits>
#include <cmath>
#include <stdio.h>
#include <string.h>
#define size 10000

using namespace std;

//frequencies of the 26 letters

double frequency[26]={0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015,
0.06094, 0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749,
0.07507, 0.01929, 0.00095, 0.05987, 0.06327, 0.09056, 0.02758,
0.00978, 0.02360, 0.00150, 0.01974, 0.00074};

//entropy function

int entropy_fun(char (&b)[size]){
   int length=strlen(b);                  // length of buffer
   int shift=0; char res; char c;
   double min=INT_MAX;                    //initialize min as the max number
   int symbols=0;
   for(int N=0; N<=25; N++){              // for every 0=<N<=25 (shift)
     int count[26]={0};                   //initialise count array. This array stores the appearance
                                          //number of the (i+1)th letter regardless of the form of the letter (lowercase or Capital)
     for(int j=0; j<length;j++){          //for every character of the file
       c=b[j];
       if(c>='A' && c<='Z'){              //if  A=<c<=Z [A=>65 Z=>90 ASCII] - Capital letters
          res=char(int(c+N-'A')%26 + int('A'));
          count[int(res-'A')]++;
       }
       else if(c>='a' && c<='z'){         //if  a=<c<=z [a=>97 z=>122 ASCII] - Lowercase letters
          res=char(int(c+N-'a')%26 + int('a'));
          count[int(res-'a')]++;
       }
       else{
         if(N==0){
            symbols++;
         }
       }
     }
     double H_N=0;                          //initialize entropy
                                            //calculate entropy as H_N = -sum{[f_N(c)]*log[f(c)]}
                                            // f(c) is the frequency that character c appears in the alphabet of text
     for(int N=0; N<=25;N++){               // f_N(c) = [number of the character c that occurs in file (regardless its form)]/[number of all characters in file]
        H_N-=(double(count[N])/(length-symbols))*log(frequency[N]);
     }
     if(H_N<min){
       min=H_N;
       shift=N;                             // keep N that minimizes entropy
     }
   }
   return shift;
}

int main(int argc, char **argv){
    char ch; char b[size]; int x=0; int N;
    FILE *file;
    file=fopen(argv[1],"r");                 // Open given file
    //file=fopen("text.txt","r");
    while((ch=fgetc(file))!=EOF){            // read characters from file and save them in buffer
      b[x]=ch;
      x++;
    }
    N = entropy_fun(b);                      // calculate shift N from entropy function

  //  decipher characters from given file

  int length=strlen(b);                     // length of buffer
  char res; char c;
  for(int i=0; i<length; i++){              //decipher all the letters of the file
     c=b[i];
     if(c>='A' && c<='Z'){                  //if  A=<c<=Z [A=>65 Z=>90 ASCII] - Capital letters
        res=char(int(c+N-'A')%26 + int('A'));
     }
     else if(c>='a' && c<='z'){             //if  a=<c<=z [a=>97 z=>122 ASCII] - Lowercase letters
        res=char(int(c+N-'a')%26 + int('a'));
     }
     else{                                  // if c is space or other symbols
       res=c;
     }
     cout<<res;                             // print every deciphered character of the file
  }
  return 0;
}
