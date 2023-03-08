#include<iostream>
#include <bits/stdc++.h>
#define INF INT_MAX
using namespace std;
const int maxN = 100000;

const int m = 2;

class adjnodelist
{
      int v;
      int weight;
  public:
      adjnodelist(int _v, int _w)  { v = _v;  weight = _w;}
      int getV()       {  return v;  }
      int getWeight()  {  return weight; }
};

class Graph
{
      int V;
      list<adjnodelist> *adj;

      void topologicalSortUtil(int v, bool visited[], stack<int> &Stack);
  public:
      Graph(int V);

      void addEdge(int u, int v, int weight);

      void shortestPath(int *buf, int s, int n, int p[][m]);
};

Graph::Graph(int V)
{
    this->V = V;
    adj = new list<adjnodelist>[V];
}

void Graph::addEdge(int u, int v, int weight)
{
    adjnodelist node(v, weight);
    adj[u].push_back(node);
}

void Graph::topologicalSortUtil(int v, bool visited[], stack<int> &Stack)
{
    visited[v] = true;

    list<adjnodelist>::iterator i;
    for (i = adj[v].begin(); i != adj[v].end(); ++i)
    {
        adjnodelist node = *i;
        if (!visited[node.getV()])
            topologicalSortUtil(node.getV(), visited, Stack);
    }

    Stack.push(v);
}

void Graph::shortestPath(int *buf, int s, int n, int p[][m])
{
    stack<int> Stack;
    int dist[V];

    bool *visited = new bool[V];
    for (int i = 0; i < V; i++)
        visited[i] = false;

    for (int i = 0; i < V; i++)
        if (visited[i] == false)
            topologicalSortUtil(i, visited, Stack);

    for (int i = 0; i < V; i++)
        dist[i] = INF;
    dist[s] = 0;

    while (Stack.empty() == false)
    {

        int u = Stack.top();
        Stack.pop();

        list<adjnodelist>::iterator i;
        if (dist[u] != INF)
        {
          for (i = adj[u].begin(); i != adj[u].end(); ++i)
             if (dist[i->getV()] > dist[u] + i->getWeight()) //something HERE
                dist[i->getV()] = dist[u] + i->getWeight();
        }
    }

    for (int i = 2; i < V; i++)
       buf[i-2] = dist[i];

     for(int i= 0; i<n-1; i++){
           int res = p[i][0] + p[i][1]*buf[i];
           cout << res << " ";
     }

}

int main(int argc, char **argv)
{

    int N;
    cin >> N;
    int v[N][3];
    int p[N][2];

    for(int i=0; i<N-1; i++){
      for(int j=0; j<3; j++){
        cin >> v[i][j];
      }
    }

    for(int i=0; i<N-1; i++){
      for(int j=0; j<2; j++){
        cin >> p[i][j];
      }
    }

    Graph g(N+1);

    for(int i=0; i<N-1; i++){
      g.addEdge(v[i][0], v[i][1], v[i][2]);
    }

    int b[N];
    int s = 1;
    g.shortestPath(b,s, N, p);

    return 0;
}
