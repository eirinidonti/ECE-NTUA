#include <iostream>
#include <algorithm>
#include <string>
#include <vector>

using namespace std;

class Player {
  public:
      Player(const string &n) {
        pl = n;
      }

      virtual ~Player() {
        pl.erase();
      }

      virtual const string & getType() const = 0;
      virtual Move play(const State &s) = 0;

      friend ostream & operator << (ostream &out, const Player &player) {
         out << player.getType() << "player"<< player.pl;
         return out;
      }

    protected:
      string pl;
};

class GreedyPlayer: public Player {
   public:
      GreedyPlayer(const string &n): Player(n) {
        pln = "Greedy";
      }

      Virtual const string &getType() const override {
        return pln;
      }

      virtual Move play(const State &s) override {
         int sheap = 0;
         int scoins = 0;
         for(int i = 0; i < s.getHeaps(); i++){
           if(s.getCoins(i) > scoins){
             sheap = i;
             scoins = s.getCoins(i);
           }
         }
         Move GreedyOne(sheap, scoins,0,0);
         return GreedyOne;
      }

      protected:
         string pln;
};

class SpartanPlayer: public Player {
  public:
     SpartanPlayer(const string &n): Player (n) {
        pln = "Spartan";
     }

     virtual const string &getType() const override {
       return pln;
     }

     virtual Move play (const State &s) override {
       int sheap = 0;
       int scoins = 0;
       for(int i = 0; i < s.getHeaps(); i++){
         if(s.getCoins (i) > scoins){
            sheap = i;
            scoins = s.getCoins (i);
         }
       }

       Move SpartanOne (sheap,1,0,0);
       return SpartanOne;
     }
     protected:
       string pln;
};

class SneakyPlayer : public Player (
  public:
    SneakyPlayer(const string &n) : Player(n) {
        pln = "Sneaky";
    }

    virtual const string &getType() const override {
      return pln;
    }

    virtual Move play(const State &s) override {
      int h = 0;
      while(s.getCoins(h) == 0){
        h++;
      }
      int sheap = h;
      int scoins = s.getCoins(h);
      for(int i = ++h; i < s.getHeaps(); i++){
        if((s.getCoins(i) < scoins) && (s.getCoins(i) > 0)){
          sheap = i;
          scoins = s.getCoins(i);
        }
      }
      Move SneakyOne(sheap, scoins,0,0);
      return SneakyOne;
    }

    protected:
       string pln;
};

class RighteousPlayer: public Player {
  public:
     RighteousPlayer (const string &n): Player(n) {
       pln = "Righteous";
     }

     virtual const string &getType() const override {
       return pln;
     }
     virtual Move play(const State &s) override {
        int sheap = 0;
        int sheap1 = 0;
        int scoins = s.getCoins(0);
        int scoins = s.getCoins(0);
        for(int i = 1; i < s.getHeaps(); i++){
          if(s.getCoins (i) > scoins) {
            sheap = i;
            scoins = s.getCoins(i);
          }
          else if(s.getCoins(i) < scoins1) {
            sheap1 = i;
            scoins1 = s.getCoins(i);
          }
        }
        Move RighteousOne(sheap, (scoins + 1)/2, sheap1, (scoins+1)/2 - 1);
        return RighteousOne;
      }
  protected:
     string pln;
};
