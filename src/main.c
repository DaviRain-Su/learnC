#include <stdio.h>

#define IN 1
#define OUT 0

// 统计数字，空白符及其他字符出现的次数
int main() {
    int nc = 0;
    int nl = 0;
    int nw = 0;
    int state = OUT;
    int ndigit[10] = {0};
    int nwhite = 0;
    int nother = 0;

    for(int c = 0; c != EOF; nc += 1) {
        if (c == '\n') {
            nl += 1;
        }
        switch (state) {
            case IN: {
                if (c >= '0' && c <= '9') {
                    ndigit[c - '0'] += 1;
                } else if (c == ' ' || c == '\t' || c == '\n') {
                    nwhite += 1;
                    state = OUT;
                } else {
                    nother += 1;
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

    printf("\nDIGITS:\n");
    for (int i = 1; i <= 10; i++) {
        printf("%3d ",i);
    }
    printf("\n");
    for (int i = 0; i < 10; i++) {
        printf("%3d ",ndigit[i]);
    }
    printf("\n");
    printf("\nWHITE SPACE: %d\n", nwhite);
    printf("\nOTHER CHARACTERS: %d\n", nother);

    return 0;
}
