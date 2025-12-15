#include <stdio.h>
#include "foo.h"

int main() {
    int nc = 0;
    int nl = 0;
    for(int c = 0; c != EOF; nc += 1) {
        if (c == '\n') {
            nl += 1;
        }
        c = getchar();
    }
    printf("\nINPUT NUMBERIS: %ld\n", nc);
    printf("\nINPUT LINEIS: %ld\n", nl);
    return 0;
}
