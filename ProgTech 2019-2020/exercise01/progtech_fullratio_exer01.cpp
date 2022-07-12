//Eirini Donti 03119839
#include <iostream>
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

rational operator + (const rational &x, const rational &y){
  int c = x.nom*y.den + y.nom*x.den;
  int v = y.den*x.den;
  return rational(c,v);
}

rational operator - (const rational &x, const rational &y){
  int c = x.nom*y.den - y.nom*x.den;
  int v = y.den*x.den;
  return rational(c,v);
}

rational operator * (const rational &x, const rational &y){
  int c = x.nom*y.nom;
  int v = x.den*y.den;
  return rational(c,v);
}

rational operator / (const rational &x, const rational &y){
  int c = x.nom*y.den;
  int v = x.den*y.nom;
  return rational(c,v);
}

ostream & operator << (std::ostream &out, const rational &x){
  if((x.nom > 0 && x.den > 0)||(x.nom < 0 && x.den < 0)){
    cout << abs(x.nom/rational::gcd(x.nom,x.den)) << "/" << abs(x.den/rational::gcd(x.nom,x.den));
  }
  if((x.nom > 0 && x.den < 0)||(x.nom < 0 && x.den > 0)){
    cout << -abs(x.nom/rational::gcd(x.nom,x.den)) << "/" << abs(x.den/rational::gcd(x.nom,x.den));
  }
  if(x.nom == 0){
    if(x.den < 0){
      cout << "0" << "/" << abs(x.den/rational::gcd(x.nom,x.den));
    }
    else {
      cout << "0" << "/" << abs(x.den/rational::gcd(x.nom,x.den));
    }
  }
  return out;
}
