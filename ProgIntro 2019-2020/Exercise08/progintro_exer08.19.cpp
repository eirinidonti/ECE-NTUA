#include <iostream>
using namespace std;

class Node {
public:
    int data;
    Node* next;
    Node* prev;
};

class LinkedList {
private:
    Node* head;
    int size;

public:
    LinkedList() {
        head = NULL;
        size = 0;
    }

    bool empty() {
        return size == 0;
    }

    int getSize() {
        return size;
    }

    void add(int index, int data) {
        if (index < 0 || index > size) {
            cout << "Invalid index." << endl;
            return;
        }

        Node* newNode = new Node;
        newNode->data = data;

        if (index == 0) {
            newNode->prev = NULL;
            newNode->next = head;
            if (head != NULL) {
                head->prev = newNode;
            }
            head = newNode;
        } else {
            Node* curr = head;
            for (int i = 0; i < index-1; i++) {
                curr = curr->next;
            }
            newNode->prev = curr;
            newNode->next = curr->next;
            if (curr->next != NULL) {
                curr->next->prev = newNode;
            }
            curr->next = newNode;
        }

        size++;
    }

    int get(int index) {
        if (index < 0 || index >= size) {
            cout << "Invalid index." << endl;
            return -1;
        }

        Node* curr = head;
        for (int i = 0; i < index; i++) {
            curr = curr->next;
        }

        return curr->data;
    }

    void remove(int index) {
        if (index < 0 || index >= size) {
            cout << "Invalid index." << endl;
            return;
        }

        Node* curr = head;
        for (int i = 0; i < index; i++) {
            curr = curr->next;
        }

        if (curr->prev == NULL) {
            head = curr->next;
        } else {
            curr->prev->next = curr->next;
        }

        if (curr->next != NULL) {
            curr->next->prev = curr->prev;
        }

        delete curr;
        size--;
    }
};

int main() {
    LinkedList list;
    int n;
    cin >> n;

    int index, data;
    for (int i = 0; i < n; i++) {
        cin >> index >> data;
        list.add(index-1, data);
    }

    int m;
    cin >> m;

    for (int i = 0; i < m; i++) {
        cin >> index;
        list.remove(index-1);
    }

    int k;
    cin >> k;
    cout << list.getSize() << " " << list.get(k-1) << endl;

    return 0;
}
