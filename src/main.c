#include <stdio.h>
#include "foo.h"

#define MAX_FAHRENHEIT 300
#define STEP 20

// 函数原型声明
void display_fahrenheit_convert_with_celsius(int fahrenheit);

int main() {
    for (int fahr = 0; fahr <= MAX_FAHRENHEIT; fahr += STEP) {
        display_fahrenheit_convert_with_celsius(fahr);
    }
    return 0;
}

void display_fahrenheit_convert_with_celsius(int fahrenheit) {
    float celsius = (fahrenheit - 32.0) * 5.0 / 9.0;
    printf("%d°F is %.2f°C\n", fahrenheit, celsius);
}
