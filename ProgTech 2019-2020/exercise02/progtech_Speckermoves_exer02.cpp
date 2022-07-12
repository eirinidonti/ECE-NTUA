#include <iostream>
#include <stdexcept>

using namespace std;

class Move {
  public: //Take sc coins from heap sh and put tc coins to heap th.
    Move(int sh, int sc, int th, int tc){
        scoins = sc;
        sheap = sh;
        tcoins = tc;
        theap = th;
    }

    int getSource() const {
       return sheap;
    }

    int getSourceCoins() const {
       return scoins;
    }

    int getTarget() const {
       return theap;
    }

    int getTargetCoins() const {
      return tcoins;
    }

    friend ostream & operator << (ostream &out, const Move &move) {
          cout << "takes " << move.scoins << " coins from heap " << move.sheap;
       if(move.tcoins != 0){
          cout << "and puts" << move.tcoins << "coins to heap" << move.theap;
       }
       else {
          cout << "and puts nothing";
       }
       return out;
     }

   protected:
     int sheap, scoins, theap, tcoins;
};

class State (
  public: //State with h heaps, where the i-th heap starts with c[i] coins.
    State(int h, const int c[]) {
       maxh = h;
       a = new int[maxh];
       for(int i = 0; i < maxh; i++){
        a[i] = i;
        a[i] = c[i];
       }
    }

    ~State() {
      delete [] a;
     }

     void next(const Move &move) throw(logic_error) {
        int s = move.getSource();
        int t = move.getTarget();
        if(s < 0|| s >= maxh || t < 0||t >= maxh) {
           throw logic_error ("invalid heap");
        }
        else if ((move.getSourceCoins() <= 0) || (move.getTargetCoins () < 0) || (move.getSourceCoins() > a[move.getSource()])) {
          throw logic_error ("invalid heap");
        }
        else {
          a[move.getSource()] = a[move.getSource()] - move.getSourceCoins();
          a[move.getTarget()] = a[move.getTarget()] + move.getTargetCoins();
        }
     }
     bool winning() const {
       for(int i = 0; i < maxh; i++){
          if(a[i] != 0){
             return false;
          }
        }
        return true;
     }

     int getHeaps() const {
        return maxh;
     }

     int getCoins (int h) const throw(logic_error) {
        int heapnow = h;
        if(heapnow < 0 || heapnow >= maxh) {
           throw logic_error("invalid heap");
        }
        return a[heapnow];
    }
    friend ostream & operator << (ostream &out, const State &state) {
       for(int j = 0; j < state.maxh-1; j++) {
          cout << state.a[j] <<", ";
       }
       cout << state.a[state.maxh-1];
       return out;
    }

  private:
    int maxh, *a;
};
