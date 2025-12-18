#include "foo.h"

int power(int base, int n) {
    int result = 1;
    for (int i = 1; i <= n; i += 1)
        result = result * base;
    return result;
}
