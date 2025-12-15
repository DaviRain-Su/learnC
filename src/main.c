#include <stdio.h>
#include "foo.h"

int main() {
    int c = 0;
    while (c != EOF) {
        putchar(c);
        c = getchar();
    }
    return 0;
}
