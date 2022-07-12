#include <iostream>
#include <vector>
#include <list>
#include <algorithm>

using namespace std;

class Graph {
   public:
      Graph(int V) {
         this->V = V;
         l = new list<int>[V];
       }
      ~Graph(){
        delete[] l;
      }
      void addEdge(int u, int v) {
         l[u].push_back(v);
       }
      bool cycle(vector<int> &path) const {
        bool *visited = new bool[V];
        bool *vec = new bool[V];
        for(int i=0; i < V; i++){
          visited[i] = false;
          vec[i] = false;
        }
        for(int i=0; i < V; i++){
           path.push_back(i);
           if(CycleHelp(i, visited, vec, path)) {
              reverse(path.begin(), path.end());
              return true;
            }
            path.clear();
          }
          path.clear();
          return false;
      }
    private:
      int V;
      list<int> *l;
      bool CycleHelp(int ve, bool visited[], bool *vec, vector<int> &path) const {
          if(visited[ve] == false) {
            visited[ve]= true;
            vec[ve] = true;
            for (auto i: l[ve]) {
               if(i == path[0]) {return true;}
               else if(!visited[i] && CycleHelp(i, visited, vec, path)) {
                  path.push_back(i);
                  return true;
               }
               else if(vec[i]) {
                  path.push_back(i);
                  return true;
                }
              }
          }
          vec[ve] = false;
          return false;
      }
};

int main() {
  int V, E;
  cin >> V >> E;
  Graph g(V);
  for (int i = 0; i < E; ++i) { int u, v; cin >> u >> v; g.addEdge(u, v); }
  vector<int> path;
  bool c = g.cycle(path);
  if (c) {
    cout << "CYCLE: ";
    for (int i = 0; i < path.size(); ++i)
    cout << path[i] << (i == path.size()-1 ? "\n" : " ");
  }
  else {
    cout << "NO CYCLE" << endl;
   }
}
