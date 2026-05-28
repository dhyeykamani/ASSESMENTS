#include <stdio.h>
#include <stdlib.h>

#define FILE_NAME "productivity_data.bin"

// Structure to hold data cleanly
typedef struct {
    float daily_hours[7];
    int data_logged; // Boolean tracker: 0 = No data, 1 = Data exists
} WeeklyTracker;

// Function Prototypes
void displayMenu();
void logHours(WeeklyTracker *tracker);
void generateReport(WeeklyTracker *tracker);
void saveToFile(WeeklyTracker *tracker);
void loadFromFile(WeeklyTracker *tracker);

int main() {
    WeeklyTracker current_week = {{0.0}, 0};
    int choice;

    // Load existing persistent data upon launching 
    loadFromFile(&current_week);

    // Menu-driven loop execution 
    do {
        displayMenu();
        printf("Enter your selection (1-4): ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                logHours(&current_week);
                saveToFile(&current_week); // Instant persistence update
                break;
            case 2:
                generateReport(&current_week);
                break;
            case 3:
                printf("\nResetting all tracker data...\n");
                current_week.data_logged = 0;
                for(int i=0; i<7; i++) current_week.daily_hours[i] = 0.0;
                saveToFile(&current_week);
                printf("Data wiped successfully.\n");
                break;
            case 4:
                printf("\nThank you for tracking with us. Stay Productive! Goodbye.\n");
                break;
            default:
                printf("\n? Invalid choice! Please enter a valid menu option.\n");
        }
    } while (choice != 4);

    return 0;
}

void displayMenu() {
    printf("\n=========================================\n");
    printf("       STUDENT PRODUCTIVITY TRACKER      \n");
    printf("=========================================\n");
    printf("1. Log Daily Study Hours\n");
    printf("2. Generate Weekly Performance Report\n");
    printf("3. Reset Weekly Tracker Data\n");
    printf("4. Exit Application\n");
    printf("=========================================\n");
}

// Log hours implementation 
void logHours(WeeklyTracker *tracker) {
    const char *days[] = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
    
    printf("\n--- Log Daily Study Hours ---\n");
    printf("Enter hours spent studying for each day:\n");
    
    for (int i = 0; i < 7; i++) {
        while (1) {
            printf("%s: ", days[i]);
            scanf("%f", &tracker->daily_hours[i]);
            
            if (tracker->daily_hours[i] >= 0 && tracker->daily_hours[i] <= 24) {
                break; // Valid input received
            }
            printf("? Invalid Entry. Hours must fall between 0 and 24.\n");
        }
    }
    tracker->data_logged = 1;
    printf("\n? Weekly logging complete!\n");
}

// Generate report implementation 
void generateReport(WeeklyTracker *tracker) {
    const char *days[] = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
    float total = 0.0, average;

    printf("\n=========================================\n");
    printf("             WEEKLY REPORT               \n");
    printf("=========================================\n");

    if (!tracker->data_logged) {
        printf("??  No data logged for this week yet. Select option 1 first.\n");
        printf("=========================================\n");
        return;
    }

    // Print breakdown matrix
    printf("Day-by-Day Log:\n");
    for (int i = 0; i < 7; i++) {
        printf("  %s: %.2f hrs | ", days[i], tracker->daily_hours[i]);
        // Visual mini-bar chart
        for(int j = 0; j < (int)tracker->daily_hours[i]; j++) printf("¦");
        printf("\n");
        total += tracker->daily_hours[i];
    }
    
    average = total / 7.0;

    printf("-----------------------------------------\n");
    printf("Total Study Time : %.2f Hours\n", total);
    printf("Daily Average    : %.2f Hours\n", average);
    printf("-----------------------------------------\n");
    
    // Insight generation logic
    if (average >= 5.0) {
        printf("Status: Outstanding performance! You're on track for excellence.\n");
    } else if (average >= 2.0) {
        printf("Status: Steady progress. Consistency will bring results!\n");
    } else {
        printf("Status: Warning. Try setting aside block intervals to raise your average.\n");
    }
    printf("=========================================\n");
}

// Save to files implementation 
void saveToFile(WeeklyTracker *tracker) {
    FILE *file = fopen(FILE_NAME, "wb");
    if (file == NULL) {
        printf("? Error: Could not save configuration data to system storage.\n");
        return;
    }
    fwrite(tracker, sizeof(WeeklyTracker), 1, file);
    fclose(file);
}

// Load from files implementation 
void loadFromFile(WeeklyTracker *tracker) {
    FILE *file = fopen(FILE_NAME, "rb");
    if (file == NULL) {
        // Safe to ignore if file doesn't exist yet on first boot
        return;
    }
    fread(tracker, sizeof(WeeklyTracker), 1, file);
    fclose(file);
}
