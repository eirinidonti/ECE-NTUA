// Kruskal's algorithm in C++
// used code from link https://www.programiz.com/dsa/kruskal-algorithm

/* We use Kruskal to find the edges with the minimum weight, and then among these edges we find the edge with the maximum weight*/

#include <algorithm>
#include <iostream>
#include <vector>
#include <fstream>
using namespace std;

#define edge pair<int, int>

class Graph {
   private:
vector<pair<int, edge> > G;  // graph
vector<pair<int, edge> > T;  // mst
  int *parent;
  int V;  // number of vertices/nodes in graph
   public:
  Graph(int V);
  void AddWeightedEdge(int u, int v, int w);
  int find_set(int i);
  void union_set(int u, int v);
  void kruskal();
  void print();
};

Graph::Graph(int V) {
  parent = new int[V];

   //i 0 1 2 3 4 5
  //parent[i] 0 1 2 3 4 5
  for (int i = 0; i < V; i++)
    parent[i] = i;

  G.clear();
  T.clear();
}
void Graph::AddWeightedEdge(int u, int v, int w) {
  G.push_back(make_pair(w, edge(u, v)));
}
int Graph::find_set(int i) {
  // If i is the parent of itself
  if (i == parent[i])
    return i;
  else
    // Else if i is not the parent of itself
    // Then i is not the representative of his set,
    // so we recursively call Find on its parent
    return find_set(parent[i]);
}
void Graph::union_set(int u, int v) {
  parent[u] = parent[v];
}
void Graph::kruskal() {
  int uRep, vRep;
  sort(G.begin(), G.end());  // increasing weight
  for (unsigned i = 0; i < G.size(); i++) {
    uRep = find_set(G[i].second.first);
    vRep = find_set(G[i].second.second);
    if (uRep != vRep) {
      T.push_back(G[i]);  // add to tree
      union_set(uRep, vRep);
    }
  }
}
void Graph::print() {
  int L;
  L = 0;
  for (unsigned i = 0; i < T.size(); i++) {
   if(T[i].first > L){
    L = T[i].first;
       }
    }
  cout  << L << endl;
}

  int main(int argc, char *argv[]) {
      ifstream my_file;
    //my_file.open("map.txt");
    my_file.open(argv[1]); //, ios::out);
      if (!my_file) {
          cout << "Cannot find the file";
       exit(1);
      }

    else {
    int n, m;
    my_file >> n; // cities
    my_file >> m; //roads

    int arr[m][3];
    for(int i=1; i<=m+1; ++i) {
      for(int j=0; j<3; ++j) {
        my_file >> arr[i][j];
      }
    }

    Graph g(n);
     for (int i=1; i<m+1; i++) {
        g.AddWeightedEdge(arr[i][0], arr[i][1], arr[i][2] );
     }
       g.kruskal();
    g.print();
          }
    return 0;
 }
