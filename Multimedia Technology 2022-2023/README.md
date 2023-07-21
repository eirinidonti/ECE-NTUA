# Multimedia Technology 2022-2023
> Lab for **Multimedia Technology** Course (7th semester)

### Structure
---

#### Lab

The task is the creation of a simple Minesweeper game application using JavaFX. [![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.java.com)

The game begins with a grid of squares (places) under which in certain positions there are a number of mines. Mine blocks are randomly chosen and the player doesn't know what they are. The game is based on revealing its squares grid when the player clicks on a square. If the square chosen to "open" contains a mine, player loses the game. If it has no mine then at square a digit appears, indicating how many neighboring blocks have mines. If there are none mines around the selected square, then the square becomes empty and all adjacent (neighboring) squares will be appeared recursively. The game ends when either player loses by choosing to open a square that contains a mine, or when all squares that do not have a mine are revealed. One of the differences in this version of the game it is about the use of time. More specifically, we assume that there is a maximum time to discover all the mines which starts counting down with the start of the game. If time runs out and the player has not discovered all the mines reveal and then the player loses. Another key difference is the existence of the "hypermine". Ιf the player marks the square corresponding to the hypermine (in "Hard" level) within the first four attempts then automatically the application will reveal the contents of all squares that are on the same line and column with the hypermine.

As we run the program, an initial window is appeared:
![image](https://github.com/eirinidonti/ECE-NTUA/assets/61821015/e2d8bf93-b637-4611-a9c1-9131a16bb1cc)

We consider a menubar, placed at the top of the screen, in which there is the Menu "Application" with submenu the requested options "Create", "Load", "Start", "Exit" and the Menu "Details" with submenu the requested options "Rounds", "Solution". The above Menu and submenu are implemented with JMenu and JMenuItem respectively. In the MenuItem “Create”, “Load”, “Rounds” Option Panes are used which create a pop up window in which the user can fill in the required fields with the keyboard to create a description file, load the description file and see the first five wins. MenuItem “Start” is executed if and only if a valid descriptor file is set to “Load”. If the submenu “Exit” is pressed, the application is terminated, while when the submenu “Solution” is pressed, the message “No Initialized Game” appears, because the first game has not been initialized.

Application Menu:
![image](https://github.com/eirinidonti/ECE-NTUA/assets/61821015/8a4afe70-3566-46e6-a0e7-20c8fc06a992)

Details Menu:
![image](https://github.com/eirinidonti/ECE-NTUA/assets/61821015/7fa541f7-013d-4c28-87f7-c692e8fe5d28)

The first game starts after we load a valid description file. The game features two levels "Easy" and "Hard":
"Easy" Level:
![image](https://github.com/eirinidonti/ECE-NTUA/assets/61821015/092eed1f-4c11-4236-b293-50bb4508d42d)

"Hard" Level:
![image](https://github.com/eirinidonti/ECE-NTUA/assets/61821015/b00f5356-1df5-4da3-8c3e-df4ce35c7750)

### Authors
---

- Eirini Donti (Owner)

<!-- ### License
--- -->
