#include <stdio.h>

int main() {
    float screen_time[7];
    float total = 0, average;
    const float HEALTHY_LIMIT = 4.0; // Definition of healthy limit in hours [cite: 35]

    printf("--- Enter 7 Days of Screen Time Data (in hours) ---\n");
    for(int i = 0; i < 7; i++) { // Accepts 7 days of data [cite: 31]
        printf("Day %d: ", i + 1);
        scanf("%f", &screen_time[i]);
        total += screen_time[i]; // Calculates Total [cite: 33]
    }

    average = total / 7.0; // Calculates Average [cite: 34]

    printf("\n--- Screen Time Report ---\n");
    printf("Total Screen Time: %.2f hours\n", total); 
    printf("Average Daily Screen Time: %.2f hours\n", average); 

    // Displays warning if average exceeds healthy limit [cite: 35]
    if (average > HEALTHY_LIMIT) {
        printf("\n??  WARNING: Your average screen time exceeds the healthy limit of %.1f hours!\n", HEALTHY_LIMIT);
        printf("Consider taking regular breaks using the 20-20-20 rule.\n");
    } else {
        printf("\n? Great job! Your screen time is within a healthy range.\n");
    }

    return 0;
}
