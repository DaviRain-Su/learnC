#include <stdio.h>
#include "foo.h"

int main() {
    int nc = 0;
    while (getchar() != EOF) {
        nc += 1;
    }
    printf("\nINPUT NUMBERIS: %ld\n", nc);
    return 0;
}
