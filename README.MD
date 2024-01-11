# LLVM Pass Development

Find more on my blog: [LLVM Pass Development I: Branch-Pointer Trace](https://beking0912.github.io/2023/12/12/llvm/)

It's for LLVM 17.

## Contribution
Biqing Su(bsu5)

## Compile & Run
1. Make the script executable by running `chmod +x setup_and_run.sh` in the terminal.
2. Execute the script by typing `./setup_and_run.sh`.

## Input
```c
#include <stdio.h>

int c;

void fun(int a) {
  printf("Value of a is %d\n", a);
}

int main() {
  void (*fun_ptr)(int) = &fun;
  (*fun_ptr)(10);

  int b;
  for (c = 0; c < 3; c++) {
    b = c + 1;
  }

  return c;
}
```

## Output
```
main: func_0x147e4af98
Branch Dictionary:
br_0: test1.c, 14, 15
br_1: test1.c, 14, 18
Value of a is 10
br_0
br_0
br_0
br_1
```

## Manually Compile & Run
```
$ mkdir build
$ cd build
$ cmake ..
$ make
$ cd ..

$ cc -c logPrint.c
$ clang -fpass-plugin='build/skeleton/SkeletonPass.dylib' -c test1.c -g
$ cc test1.o logPrint.o
$ ./a.out
```

## Test Files

### **test1.c**
- **Type:** small contrived program
- **Code source:** from project description
- **Run test:** execute the `setup_and_run.sh` script.
- **Result:**
<img src="https://s2.loli.net/2023/12/11/IN2onFDPiHdLk4A.png" width="50%">

### **test2.c**
- **Type:** small contrived program
- **Code source:** generate by gpt4
- **Run test:** change `test1` to `test2` in `setup_and_run.sh` before executing the script.
- **Result:**
<img src="https://s2.loli.net/2023/12/11/rLUSTMjKIlOZw9A.png" width="50%">


### **test3.c**
- **Type:** real-world substitute
- **Code source:** [Employee Management System github link](https://github.com/ssoad/Employee-Management-System/blob/master/Employee%20Management%20System-github.c)
- **Number of non-comment non-blank lines:** 583 lines
- **Changes made:** added function getch; moved the main to the end.
- **Run test:** change `test1` to `test3` in `setup_and_run.sh` before executing the script.
- **Result:**
<img src="https://s2.loli.net/2023/12/11/OuDQChPKmrBtyVc.png" width="50%">
