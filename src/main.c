#include <stdio.h>
#include "foo.h"

// 函数原型声明
void display_fahrenheit_convert_with_celsius(int fahrenheit);

int main() {
    int upper = 300;
    int step = 20;
    for (int fahr = 0; fahr <= upper; fahr += step) {
        display_fahrenheit_convert_with_celsius(fahr);
    }
    return 0;
}

void display_fahrenheit_convert_with_celsius(int fahrenheit) {
    float celsius = (fahrenheit - 32.0) * 5.0 / 9.0;
    printf("%d°F is %.2f°C\n", fahrenheit, celsius);
}
