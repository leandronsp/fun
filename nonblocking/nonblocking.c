#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

void cleanup() {
    printf("Cleaning up...\n");
    unlink("client0");
    unlink("client1");
    printf("Bye!\n");
}

int main() {
    atexit(cleanup);

    mkfifo("client0", 0666);
    mkfifo("client1", 0666);

    printf("Server started...\n");

    int fd0 = open("client0", O_RDONLY | O_NONBLOCK);
    int fd1 = open("client1", O_RDONLY | O_NONBLOCK);

    while (1) {
        char line0[128];
        char line1[128];

        // Non-blocking read from client0
        ssize_t data0 = read(fd0, line0, sizeof(line0) - 1);
        if (data0 > 0) {
            line0[data0] = '\0';
            printf("Message from client0: %s\n", line0);
        }

        // Non-blocking read from client1
        ssize_t data1 = read(fd1, line1, sizeof(line1) - 1);
        if (data1 > 0) {
            line1[data1] = '\0';
            printf("Message from client1: %s\n", line1);
        }

        // Sleep for 0.5 second
        usleep(500000);
    }

    return 0;
}
