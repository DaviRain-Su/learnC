#include <stdio.h>

#define IN 1
#define OUT 0

int main() {
    int nc = 0;
    int nl = 0;
    int nw = 0;
    int state = OUT;

    for(int c = 0; c != EOF; nc += 1) {
        if (c == '\n') {
            nl += 1;
        }
        switch (state) {
            case IN: {
                if (c == ' ' || c == '\t' || c == '\n') {
                    state = OUT;
                }
                break;
            }
            case OUT: {
                state = IN;
                nw += 1;
                break;
            }
        }
        c = getchar();
    }
    printf("\nINPUT NUMBERIS: %ld\n", nc);
    printf("\nINPUT LINEIS: %ld\n", nl);
    printf("\nINPUT WORDIS: %ld\n", nw);
    return 0;
}
