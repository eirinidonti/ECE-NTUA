#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main() {
    string inputFileName = "in.txt";
    string outputFileName = "out.txt";
    ifstream inputFile(inputFileName);

    int lineWidth = 60;  // maximum width of each line
    string outputString = "";

    if (inputFile) {
        string word;
        inputFile >> word;
        int currentLineLength = word.length();

        outputString += word;

        while (inputFile >> word) {
            if (currentLineLength + 1 + word.length() > lineWidth) {
                int spacesToAdd = lineWidth - currentLineLength;
                outputString += string(spacesToAdd, ' ');
                outputString += '\n';
                currentLineLength = 0;
            } else {
                outputString += ' ';
                ++currentLineLength;
            }

            outputString += word;
            currentLineLength += word.length();
        }

        int spacesToAdd = lineWidth - currentLineLength;
        if (spacesToAdd > 0) {
            outputString += string(spacesToAdd, ' ');
        }
    } else {
        cout << "Error opening files." << endl;
    }

    inputFile.close();

    ofstream outputFile(outputFileName);
    if (outputFile) {
        outputFile << outputString;
    } else {
        cout << "Error opening output file." << endl;
    }

    outputFile.close();

    return 0;
}
