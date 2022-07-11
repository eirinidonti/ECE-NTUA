#include <iostream>
#include <math.h>

using namespace std;

class Polynomial (
  protected:
   class Term {
    public:
      int exponent;
      int coefficient;
      Term *next;
      Term(int exp, int coeff, Term *n) {
         exponent = exp;
         coefficient = coeff;
         next = n;
       }
       friend class Polynomial;
   };
   private:
     Term *pol;
   public:
     Polynomial() {
        pol = nullptr;
     }

     Polynomial (const Polynomial &p){
       Term *poly = p.pol;
       while( poly != nullptr) {
          this->addTerm( poly-> exponent, poly -> coefficient);
          poly = poly->next;
       }
     }

     ~Polynomial() { delete pol; }

     Polynomial & operator = (const Polynomial &p) {
        delete pol;
        Term *poly = p.pol;
        while( poly != nullptr){
          this -> addTerm(poly-> exponent, poly -> coefficient);
          poly = poly->next;
        }
        return *this;
     }

     void addTerm(int expon, int coeff) {
       if (pol == nullptr) {
         Term *poly = new Term(expon, coeff, nullptr);
         pol = poly;
         return;
       }
       Term *pterm1 = pol;
       Term *prev  = pol;
       while(pterm1 != nullptr) {
          if(pterm1->exponent == expon) {
             pterm1 -> coefficient += coeff;
             return;
          }
          else if(pterm1 -> exponent < expon ) {
             Term *poly = new Term(expon, coeff, ptenm1);
             ptermi = poly;
             pol = poly;
             return;
         }
         else {
           Term *pterm2 = pterm1 -> next;
           if(pterm2 == nullptr || pterm2 -> exponent < expon){
             if(coeff != 0){
               Term *poly1 = new Term(expon, coeff, pterm2);
                  pterm1 -> next = poly1;
             }
             return;
           }
           else {
             prev = pterm1;
             pterm1 = pterm1 -> next;
           }
         }
      }
    }

    double evaluate(double x) {
      Term *t = pol;
      double sum = 0.0;
      while (t != nullptr) {
        sum += (t-> coefficient)*pow(x,t -> exponent);
        t=t->next;
      }
      return sum;
    }

    friend Polynomial operator+ (const Polynomial &p, const Polynomial &q) {
      Polynomial res;
      Term *pterm = p.pol;
      Term *qterm = q.pol;
      while(pterm != nullptr && qterm != nullptr) {
        if(pterm-> exponent == qterm -> exponent){
          if (pterm -> coefficient + qterm -> coefficient != 0){
            res.addTerm(pterm -> exponent, pterm -> coefficient + qterm -> coefficient);
          }
          pterm = pterm->next;
          qterm = qterm->next;
        }
        else if (pterm->exponent > qterm-> exponent) {
          if(pterm-> coefficient != 0) {
             res.addTerm(pterm-> exponent, pterm-> coefficient);
          }
          pterm = pterm->next;
        }
        else {
          if(qterm -> coefficient != 0) {
             res.addTerm(qterm-> exponent, qterm-> coefficient);
           }
           qterm = qterm->next;
         }
       }
       while(pterm != nullptr) {
          if(pterm -> coefficient != 0) {
            res.addTerm(pterm-> exponent, pterm-> coefficient);
          }
          pterm = pterm->next;
        }
      }
      while(qterm != nullptr){
         if(qterm-> coefficient != 0){
          res.addTerm( qterm->exponent, qterm-> coefficient);
         }
         qterm = qterm->next;
       }
       return res;
     }

     friend Polynomial operator* (const Polynomial &p, const Polynomial &q) {
        Polynomial res;
        Term *pt = p.pol;
        Term *qt = q.pol;
        while(pt != nullptr) {
          while(qt != nullptr) {
            res.addTerm(pt -> exponent + qt -> exponent, pt -> coefficient* (qt -> coefficient));
            qt = qt->next;
          }
         qt= q.pol;
         pt = pt->next;
       }
       return res;
     }

    friend ostream & operator << (ostream &out, const Polynomial &p) {
      bool flag = true;
      Term *poly = p.pol;
      if(poly == nullptr) {
         out << 0;
       }
       while (poly != nullptr) {
          if( poly == p.pol && poly -> coefficient == 0){
            while(poly -> coefficient == 0 && poly -> next != nullptr) {
              poly = poly->next;
            }
          }
          if(poly -> coefficient != 0){
             flag = false;
             if(poly -> coefficient < 0) {
               if( poly == p.pol) {
                 out << "- ";
               }
               else {
                 out << " - ";
               }
             }
             if( abs(poly-> coefficient) != 1) {
                out << abs(poly -> coefficient);
             }
             else {
               if(poly-> exponent == 0) {
                 out << abs(poly -> coefficient);
               }
             }
             if(poly-> exponent != 0){
               out << "x";
               if( poly-> exponent != 1){
                  out << "^" << poly -> exponent;
               }
             }
           }
           else{
             if(poly->next == nullptr && flag == true) {
               out << 0;
             }
           }
           poly = poly->next;
           if (poly != nullptr && poly-> coefficient > 0) {
              out << " + ";
            }
          }
          return out;
        }
      };
