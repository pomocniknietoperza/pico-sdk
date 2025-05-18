#include "pico/stdlib.h"
#include "hardware/gpio.h"

#define BUTTON_PIN_14  14
#define BUTTON_PIN_15  15
#define OUTPUT_PIN_0    0
#define OUTPUT_PIN_1    1

int main() {
    // Inicjalizacja stdio (opcjonalne, jeśli potrzebne printf)
    stdio_init_all();

    // Konfiguracja przycisków jako wejścia z podciągnięciem do GND
    gpio_init(BUTTON_PIN_14);
    gpio_set_dir(BUTTON_PIN_14, GPIO_IN);
    gpio_pull_down(BUTTON_PIN_14);

    gpio_init(BUTTON_PIN_15);
    gpio_set_dir(BUTTON_PIN_15, GPIO_IN);
    gpio_pull_down(BUTTON_PIN_15);

    // Konfiguracja wyjść
    gpio_init(OUTPUT_PIN_0);
    gpio_set_dir(OUTPUT_PIN_0, GPIO_OUT);

    gpio_init(OUTPUT_PIN_1);
    gpio_set_dir(OUTPUT_PIN_1, GPIO_OUT);

    // Początkowy stan (Pin 0 i Pin 1 = LOW)
    gpio_put(OUTPUT_PIN_0, 0);
    gpio_put(OUTPUT_PIN_1, 0);

    while (true) {
        if (gpio_get(BUTTON_PIN_14)) {  // Jeśli przycisk 14 naciśnięty
            gpio_put(OUTPUT_PIN_0, 1);  // Pin 0 = HIGH
            gpio_put(OUTPUT_PIN_1, 0);  // Pin 1 = LOW
            printf("Przycisk 14: Pin0=HIGH, Pin1=LOW\n");
            sleep_ms(200);  // Debounce (opóźnienie przeciw drganiom)
        }

        if (gpio_get(BUTTON_PIN_15)) {  // Jeśli przycisk 15 naciśnięty
            gpio_put(OUTPUT_PIN_0, 1);  // Pin 0 = HIGH
            gpio_put(OUTPUT_PIN_1, 1);  // Pin 1 = HIGH
            printf("Przycisk 15: Pin0=HIGH, Pin1=HIGH\n");
            sleep_ms(200);  // Debounce
        }

        sleep_ms(50);  // Małe opóźnienie, aby zmniejszyć obciążenie CPU
    }

    return 0;
}
