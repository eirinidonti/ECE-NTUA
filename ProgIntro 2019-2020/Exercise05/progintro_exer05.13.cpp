 #include <iostream>
 #include <string>
 using namespace std;

 string encrypt(string message, string key) {
     string encrypted = "";
     int keyLength = key.length();

     for (int i = 0; i < message.length(); i++) {
         char c = message[i];
         if (isalpha(c)) { // check if c is a letter
             char upperC = toupper(c);
             int index = upperC - 'A';
             char newC = toupper(key[index]);
             encrypted += isupper(c) ? newC : tolower(newC);
         } else {
             encrypted += c;
         }
     }

     return encrypted;
 }

 string decrypt(string message, string key) {
     string decrypted = "";
     int keyLength = key.length();

     for (int i = 0; i < message.length(); i++) {
         char c = message[i];
         if (isalpha(c)) { // check if c is a letter
             char upperC = toupper(c);
              int index = key.find(upperC);
              char newC = index + 'A';
             decrypted += isupper(c) ? newC : tolower(newC);
         } else {
             decrypted += c;
         }
     }

     return decrypted;
 }

 int main() {
     string key, mode;
     getline(cin, key);
     getline(cin, mode);

     string message;
     while (getline(cin, message)) {
         string result = mode == "encrypt" ? encrypt(message, key) : decrypt(message, key);
         cout << result << endl;
     }

     return 0;
 }
