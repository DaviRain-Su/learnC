#include <stdio.h>
#include "foo.h"

#define IN 1
#define OUT 0

int main() {
    for (int i = 0; i < 10; i += 1) {
        printf("%3d %3d %3d\n", i, power(2, i), power(-3, i));
    }
    return 0;
}
