#include <stdio.h>

int main() {
    float hours;

    printf("Enter the number of hours studied today: ");
    scanf("%f", &hours); // Takes user input [cite: 26]

    // Displays motivation messages based on conditions [cite: 27, 28]
    if (hours < 0) {
        printf("Invalid input! Hours cannot be negative.\n");
    } else if (hours == 0) {
        printf("Productivity starts with a single step! Try doing just 15 minutes now.\n");
    } else if (hours > 0 && hours < 3) {
        printf("Good start! Keep building up that momentum.\n");
    } else if (hours >= 3 && hours <= 6) {
        printf("Fantastic! You are in the zone. Great effort today!\n");
    } else {
        printf("Wow, champion status! Remember to take a break and rest your eyes.\n");
    }

    return 0;
}
