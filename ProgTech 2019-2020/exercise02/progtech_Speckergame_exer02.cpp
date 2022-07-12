#include <iostream>
#include <stdexcept>

using namespace std;

class Game (
  public:
    Game(int heaps, int players) {
      hcoins = new int[heaps];
      gheaps = heaps;
      gplayers = players;
      heapnow = 0;
      playernow = 0;
      pllist = new Player*[players];
    }

    ~Game() {
      delete [] hcoins;
      delete [] pllist;
    }

    void addHeap(int coins) throw(logic_error) {
      int c = coins;
      if(heapnow > gheaps) {
        throw logic_error("Invalid Heap");
      }
      else if (c < 0) {
        throw logic_error("Invalid Coins");
      }
      else {
        hcoins[heapnow++] = c;
      }

      void addPlayer (Player *player) throw(logic_error) {
        if( playernow > gplayers){
          throw logic error("Invalid Player");
        }
        else {
          pllist[playernow++] = player;
        }
      }

      void play(ostream &out) throw(logic_error) {
        if(heapnow != gheaps && playernow != gplayers) {
           throw logic_error("Invalid data");
        }
        else{
          int j = 0;
          State s(gheaps, hcoins);
          while(!s.winning()){
            out << "State: " << s << endl;
            out << pllist[j%gplayers] << " " << pllist[j%players] -> play(s) << endl;
            s.next( pllist[j%gplayers] -> play(s));
            j++;
          }
          out << "State: " << s << endl;
          j--;
          out << *pllist[j%gplayers] << " wins" << endl;
        }
      }

    protected:
      int gheaps, gplayers, heapnow, playernow, *hcoins;
      Player **pllist;
};
