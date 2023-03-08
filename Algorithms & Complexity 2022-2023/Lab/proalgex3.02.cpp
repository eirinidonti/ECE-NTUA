#include <vector>
#include <set>
#include <iostream>

using namespace std;

#define maxN 1000
#define INF 1000000000

long int N, M, s, t, B;

vector<vector<bool>> visited(maxN);
vector<vector<pair<int, int>>> adj(maxN);
vector<vector<int>> dist(maxN);
set<pair<int, pair<int, int>>> queue;

// Modified Dijkstra Implementation
void modDijkstra() {
    while (!queue.empty()) {
        pair<int, pair<int, int>> forward = *queue.begin();
        queue.erase(queue.begin());

        int curr_vertex = forward.second.first;
        int shortc = forward.second.second;
        visited[shortc][curr_vertex] = true;

        for (auto x:adj[curr_vertex]) {
            int v = x.first;
            int l = x.second;
            // current number of shortcuts
            if (!visited[shortc][v] && dist[shortc][v] > dist[shortc][curr_vertex] + l) {
                if (dist[shortc][v] != INF) {
                    queue.erase(queue.find(make_pair(dist[shortc][v], make_pair(v, shortc))));
                }
                dist[shortc][v] = dist[shortc][curr_vertex] + l;
                queue.insert(make_pair(dist[shortc][v], make_pair(v, shortc)));
            }
            // next number of shortcuts
            if (shortc+1 < N && !visited[shortc+1][v] && dist[shortc+1][v] > dist[shortc][curr_vertex]) {
                if (dist[shortc+1][v] != INF) {
                    queue.erase(queue.find(make_pair(dist[shortc+1][v], make_pair(v, shortc+1))));
                }
                dist[shortc+1][v] = dist[shortc][curr_vertex];
                queue.insert(make_pair(dist[shortc+1][v], make_pair(v, shortc+1)));
            }
        }
    }
}

int main(int argc,char **argv) {
    cin >> N >> M >> s >> t >> B;  //Read from input

    for (int i = 1; i <= M; i++) {
        int ui, vi, li;
        cin >> ui >> vi >> li;
        adj[ui].push_back(make_pair(vi,li));
    }

    for (int i = 0; i <= N; i++)  //Initialize Variables
        for (int j = 0; j <= N; j++) {
            visited[i].push_back(false);
            dist[i].push_back(INF);
        }

    dist[0][s] = 0;
    queue.insert(make_pair(0, make_pair(s,0)));
    modDijkstra();

    for (int j = 0; j <= N; j++) {
        if (dist[j][t] <= B) {
            cout << j << endl;
            return 0;
        }
    }
}
