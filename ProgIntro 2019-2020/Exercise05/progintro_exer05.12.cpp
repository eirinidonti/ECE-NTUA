// #include <iostream>
// #include <string>
// #include <algorithm>
//
// using namespace std;
//
// int main() {
//     string alphabet, text;
//     getline(cin, alphabet);
//
//     // Remove any spaces or non-alphabetic characters from the alphabet
//     alphabet.erase(remove_if(alphabet.begin(), alphabet.end(),
//                     [](char c) { return !isalpha(c); }), alphabet.end());
//
//     // Read lines of text until the end of the input is reached
//     while(getline(cin, text)) {
//         // Make sure the text is in all lowercase
//         transform(text.begin(), text.end(), text.begin(), [](char c) { return tolower(c); });
//
//         // Encode the text using the given alphabet
//         string encoded_text = "";
//         for(char c : text) {
//             if(isalpha(c)) {
//                 int index = c - 'a';
//                 encoded_text += alphabet[index];
//             } else {
//                 encoded_text += c;
//             }
//         }
//
//         cout << encoded_text << endl;
//     }
//
//     return 0;
// }
#include <iostream>
#include <string>
#include <algorithm>
#include <cctype>

using namespace std;

int main() {
    string alphabet, text;
    getline(cin, alphabet);

    // Remove any spaces or non-alphabetic characters from the alphabet
    alphabet.erase(remove_if(alphabet.begin(), alphabet.end(),
                    [](char c) { return !isalpha(c); }), alphabet.end());

    // Read lines of text until the end of the input is reached
    while(getline(cin, text)) {
        // Encode the text using the given alphabet
        string encoded_text = "";
        for(char c : text) {
            if(isalpha(c)) {
                // Check if the character is uppercase
                bool is_uppercase = isupper(c);

                // Convert to lowercase for encoding
                c = tolower(c);

                int index = c - 'a';
                char encoded_char = alphabet[index];

                // Convert encoded character back to uppercase if necessary
                if(is_uppercase) {
                    encoded_char = toupper(encoded_char);
                }

                encoded_text += encoded_char;
            } else {
                encoded_text += c;
            }
        }

        cout << encoded_text << endl;
    }

    return 0;
}
