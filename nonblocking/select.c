#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/select.h>

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

    // Create fd_set and add file descriptors to it
    fd_set readfds;
    int max_fd = fd0 > fd1 ? fd0 : fd1; // Determine the maximum file descriptor number

    while (1) {
        // Initialize the fd_set
        FD_ZERO(&readfds);
        FD_SET(fd0, &readfds);
        FD_SET(fd1, &readfds);

        // Using select to wait for activity on the file descriptors
        select(max_fd + 1, &readfds, NULL, NULL, NULL);

        char line[128];
        ssize_t data;

        // Check which file descriptor has data ready to be read
        if (FD_ISSET(fd0, &readfds)) {
            data = read(fd0, line, sizeof(line) - 1);
            if (data > 0) {
                line[data] = '\0';
                printf("Message from client0: %s\n", line);
            }
        }

        if (FD_ISSET(fd1, &readfds)) {
            data = read(fd1, line, sizeof(line) - 1);
            if (data > 0) {
                line[data] = '\0';
                printf("Message from client1: %s\n", line);
            }
        }
    }

    return 0;
}
