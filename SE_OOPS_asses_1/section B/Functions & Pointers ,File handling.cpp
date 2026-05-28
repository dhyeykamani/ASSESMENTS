#include <stdio.h>

// Function Declarations utilizing pointers to modify values directly
void saveData(const char* filename, int *hours);
void loadData(const char* filename, int *hours);

int main() {
    const char* filename = "session_data.txt";
    int current_hours = 0;

    // Read and display data on program restart [cite: 39]
    printf("Checking for saved data...\n");
    loadData(filename, &current_hours);
    printf("Current loaded study hours: %d\n\n", current_hours);

    // Simulate updating data during run
    printf("Enter new study hours to add to your record: ");
    int new_hours;
    scanf("%d", &new_hours);
    current_hours += new_hours;

    // Save updated data back to file [cite: 42]
    saveData(filename, &current_hours);
    printf("Progress successfully saved to file. Run the app again to view it!\n");

    return 0;
}

// Function to write data using pointers [cite: 36, 42]
void saveData(const char* filename, int *hours) {
    FILE *file = fopen(filename, "w");
    if (file != NULL) {
        fprintf(file, "%d", *hours);
        fclose(file);
    } else {
        printf("Error: Could not save data.\n");
    }
}

// Function to read data using pointers [cite: 36, 39, 42]
void loadData(const char* filename, int *hours) {
    FILE *file = fopen(filename, "r");
    if (file != NULL) {
        fscanf(file, "%d", hours);
        fclose(file);
    } else {
        // If file doesn't exist, treat it as a fresh start
        *hours = 0;
    }
}
