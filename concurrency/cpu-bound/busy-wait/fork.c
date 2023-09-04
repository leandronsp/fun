#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/wait.h>

int answer = 0;

// Function to mimic busy_wait
void busy_wait(time_t n) {
    time_t end_time = time(NULL) + n;
    while (time(NULL) < end_time) {
        answer = 41 + 1;
    }
}

int main() {
    printf("Main process: %d\n", getpid());

    time_t initial_time = time(NULL);
    pid_t pid;

    // Create 8 processes
    for (int i = 0; i < 8; ++i) {
        pid = fork();
        
        if (pid == 0) {  // Child process
            printf("Forking process: %d\n", getpid());
            time_t p_initial_time = time(NULL);
            busy_wait(20);
            printf("Forking process finished in %ld seconds\n", time(NULL) - p_initial_time);
            return 0;  // Exit child process
        } else if (pid < 0) {
            printf("Fork failed!\n");
            return 1;  // Exit with error
        }
    }

    // Wait for all child processes to finish
    for (int i = 0; i < 8; ++i) {
        wait(NULL);
    }

    printf("Total time: %ld seconds\n", time(NULL) - initial_time);

    return 0;
}
