//1a
#include "pzhelp"
PROGRAM {
 ("hello world");
}
//1b
#include "pzhelp"
PROGRAM {
 WRITELN("hello", "world");
}
//1c
#include "pzhelp"
PROGRAM {
 WRITE("hello "); WRITELN("world");
}
//1d
#include "pzhelp"
PROGRAM {
 WRITE("hello", "world"); WRITELN();
}
//2
#include "pzhelp"
PROC hello () {
 WRITELN("hello world");
}
PROGRAM {
 hello(); hello(); hello(); hello();
}
//3
#include "pzhelp"
PROC hello () {
 WRITELN("hello world");
}
PROGRAM {
 int i;
 FOR(i, 1 TO 20) hello();
}
//4
#include "pzhelp"
const int n = 20;
int i;
PROC num_hello () {
 WRITELN(i, "hello world");
}
PROGRAM {
 FOR(i, 1 TO n) num_hello();
}
//5
#include "pzhelp"
PROC hello () {
 WRITELN("hello world");
}
PROGRAM {
 int n, i;
 WRITE("Give number of greetings",
 "then press <enter>: ");
 n = READ_INT();
 FOR(i, 1 TO n) hello();
}
//6
#include "pzhelp"
PROC hello () {
 WRITELN("hello world");
}
PROGRAM {
 int n, i;
 WRITE("Give number of greetings then press <enter>: ");
 n = READ_INT();
 if (n < 0) WRITELN("The number", n, "is negative");
 else FOR(i, 1 TO n) hello();
}
