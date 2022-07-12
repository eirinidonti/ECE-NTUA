#include <iostream>
#include <iomanip>
#include <stdexcept>

using namespace std;

class ChessBoardArray {

  protected:
    int *data;
    int totalbase;
    int num;
    class Row {
     public:
       Row(ChessBoardArray &a, int i): array(a), row(i) {}
        int & operator [] (int i) const {
            return array.select(row, i);
        }
     private:
       ChessBoardArray & array;
       int row;
   };

   class ConstRow {
     public:
      ConstRow(const ChessBoardArray &a, int i): array(a), row(i) {}
      const int operator [] (int i) const {
         return array.select(row,i);
      }
     private:
      const ChessBoardArray & array;
      int row;
  };

 unsigned loc(int i, int j) const throw(out_of_range){
     int di = i - totalbase;
     int dj = j - totalbase;
     if( di < 0 || di>= num || dj < 0 || dj >= num) {
        throw out_of_range("invalid index");
     }
     else if((di%2 !=  0 && dj%2 == 0) || (di%2 == 0 && dj%2 !=0)){
       throw out_of_range("invalid index");
     }
     else{
       return di*num + dj;
     }
  }

 public:
   ChessBoardArray(unsigned size = 0, unsigned base = 0): num(size), data(new int[(size*size + 1)/2]), totalbase(base) {}
   ChessBoardArray(const ChessBoardArray &a): data(new int[((a.num)*(a.num)+1)/2]), num(a.num), totalbase(a.totalbase) {
      for (int i = 0; i < ((a.num)*(a.num) + 1)/2; ++i) {data[i] = a.data[i];}
    }

   ~ChessBoardArray() { delete [] data; }

   ChessBoardArray & operator= (const ChessBoardArray &a) {
     delete [] data;
     totalbase = a.totalbase;
     num = a.num;
     data = new int[((a.num)*(a.num) + 1)/2];
     for (int i = 0; i <((a.num)*(a.num)+1)/2; ++i) { data[i] = a.data[i]; }
    return *this;
   }
   int & select(int i, int j) { return data[loc(i, j)/2]; }
   int select(int i, int j) const { return data[loc(i, j)/2]; }

   const Row operator [] (int i) { return Row(*this, i); }
   const ConstRow operator [] (int i) const { return ConstRow(*this, i); }

   friend ostream & operator << (ostream &out, const ChessBoardArray &a) {
      if(a.num%2 != 0) {
        for (int i =0; i < (a.num); i++) {
           for(int j = 0; j < (a.num); j++) {
              if((i*a.num + j)%2 == 0) {
                out << setw(4) << a.data[(i*a.num +j)/2];
              }
              else{
                out << setw(4) << 0;
              }
           }
           out << endl;
         }
     }
     else {
      for(int i = 0; i < (a.num); i++) {
        for (int j = 0; j < (a.num); j++){
          if(i%2 == 0){
            if(j%2 == 0){
              out << setw(4) << a.data[(i*a.num + j)/2];
            }
            else {
              cout << setw(4) << 0;
            }
          }
          else {
            if(j%2 != 0){
              out << setw(4) << a.data[(i*a.num + j-1)/2);
            }
            else {
              cout << setw(4) << 0;
            }
          }
        }
        out << endl;
      }
    }
    return out;
  }
};
