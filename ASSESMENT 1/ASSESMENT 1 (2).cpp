#include <stdio.h>

int main() {
    int choice, quantity, totalAmount = 0;
    char moreOrders;

    do {
    	//menu
        printf("1. Pizza      - 180 Rs/pcs\n");
        printf("2. Burger     - 100 Rs/pcs\n");
        printf("3. Dosa       - 120 Rs/pcs\n");
        printf("4. Idli       - 50 Rs/pcs\n");
        printf("Enter your choice (1-4): ");
        scanf("%d", &choice);
//choice
        if (choice < 1 || choice > 4) {
            printf("\nInvalid choice! Please enter a number between 1 and 4.\n");
            continue;
        }
//quantity
        printf("Enter the quantity: ");
        scanf("%d", &quantity);

//  price based on choice
        int price = 0;
        if (choice == 1) {
            printf("You selected Pizza: \n");
            price = 180;
        } else if (choice == 2) {
            printf("You selected Burger: \n");
            price = 100;
        } else if (choice == 3) {
            printf("You selected Dosa: \n");
            price = 120;
        } else if (choice == 4) {
            printf("You selected Idli: \n");
            price = 50;
        }

        int amount = price * quantity;
        printf("Amount for this order: %d\n", amount);
        totalAmount += amount;
        printf("Total Amount so far: %d\n", totalAmount);

        // if the user wants to order more
        printf("Do you want to place another order? (Y/N): ");
        scanf(" %c", &moreOrders);

    } while (moreOrders == 'Y' || moreOrders == 'N'); // Repeat if user enters 'y'

    //  final total bill
    printf("Final Total Amount: %d Rs\n", totalAmount);
    printf("Thank you for your order!\n");

    return 0;
}

