#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <poll.h>

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

    // Create an array of pollfd structs
    struct pollfd fds[2];
    fds[0].fd = fd0;
    fds[0].events = POLLIN;
    fds[1].fd = fd1;
    fds[1].events = POLLIN;

    while (1) {
        // Using poll to wait for activity on the file descriptors
        poll(fds, 2, -1);

        char line[128];
        ssize_t data;

        // Check which file descriptor has data ready to be read
        if (fds[0].revents & POLLIN) {
            data = read(fd0, line, sizeof(line) - 1);
            if (data > 0) {
                line[data] = '\0';
                printf("Message from client0: %s\n", line);
            }
        }

        if (fds[1].revents & POLLIN) {
            data = read(fd1, line, sizeof(line) - 1);
            if (data > 0) {
                line[data] = '\0';
                printf("Message from client1: %s\n", line);
            }
        }
    }

    return 0;
}
