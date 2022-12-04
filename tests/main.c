#include <stdio.h>

int pow_(int a, int b) {

    int r = 1;

    while (b > 0) {

        if (b % 2 != 0) {
            r = r * a;
        }

        a = a * a;
        b = b / 2;
    }

    return r;
}

int main() {
    printf("%d^%d=%d", 12, 3, pow_(12, 3));

    return 0;
}
