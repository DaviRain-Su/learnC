#include <stdio.h>
#include "foo.h"

int main() {
    int c = 0;
    while ((c = getchar()) != EOF) {
        putchar(c);
    }
    return 0;
}
