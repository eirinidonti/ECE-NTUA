//Eirini Donti 03119839
#include <iostream>
#include <cstdio>
#include "pzhelp"
#ifndef CONTEST
#include "babyratio.hpp"
#endif

using namespace std;

int rational:: gcd(int a, int b){
  a = abs(a); b = abs(b);
  while(a > 0 && b > 0){
    if(a > b) a = a % b; else b = b % a;
  }
  return(a + b);
}

rational::rational (int n, int d){
  nom=n;
  den=d;
}

rational rational:: add(rational r){
  int c = r.nom*den + nom*r.den;
  int s = den*r.den;
  return rational(c,s);
}

rational rational:: sub(rational r){
  int c = r.den*nom - den*r.nom;
  int s = den*r.den;
  return rational(c,s);
}

rational rational:: mul(rational r){
  int c = r.nom*nom;
  int s = den*r.den;
  return rational(c,s);
}

rational rational:: div(rational r){
  int c = r.den*nom;
  int s = r.nom*den;
  return rational(c,s);
}

rational rational:: print(){
  if((nom > 0 && den > 0)||(nom < 0 && den < 0)){
    cout << abs(nom/gcd(nom,den)) << "/" << abs(den/gcd(nom,den));
  }
  if((nom > 0 && den < 0)||(nom < 0 && den > 0)) {
    cout << -abs(nom/gcd(nom,den)) << "/" << abs(den/gcd(nom,den));
  }
  if(nom == 0){
    if(den < 0){
      cout << "0" << "/" << abs(den/gcd(nom,den));
    }
    else {
      cout << "0" << "/" << abs(den/gcd(nom,den));
    }
  }
}
