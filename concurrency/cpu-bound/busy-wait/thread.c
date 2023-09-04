#include <stdio.h>
#include <pthread.h>
#include <time.h>

int answer = 0;

// Function to mimic busy_wait
void *busy_wait(void *arg) {
    int idx = (int)arg;
    printf("Thread %d started.\n", idx);

    time_t end_time = time(NULL) + 20;  // Run for 20 seconds

    while (time(NULL) < end_time) {
        answer = 41 + 1;
    }

    printf("Thread %d finished.\n", idx);
    return NULL;
}

int main() {
    printf("Main process.\n");
    printf("Main thread.\n");

    pthread_t threads[8];
    time_t initial_time = time(NULL);

    // Start 8 threads
    for (int i = 0; i < 8; ++i) {
        pthread_create(&threads[i], NULL, busy_wait, (void*)i);
    }

    // Wait for all threads to finish
    for (int i = 0; i < 8; ++i) {
        pthread_join(threads[i], NULL);
    }

    printf("Total time: %ld seconds\n", time(NULL) - initial_time);

    return 0;
}
