#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/epoll.h>

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

    int epoll_fd = epoll_create1(0);
    if (epoll_fd == -1) {
        perror("epoll_create1");
        exit(EXIT_FAILURE);
    }

    struct epoll_event event;
    event.events = EPOLLIN;

    event.data.fd = fd0;
    if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd0, &event) == -1) {
        perror("epoll_ctl");
        exit(EXIT_FAILURE);
    }

    event.data.fd = fd1;
    if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, fd1, &event) == -1) {
        perror("epoll_ctl");
        exit(EXIT_FAILURE);
    }

    struct epoll_event events[2];

    while (1) {
        int num_fds = epoll_wait(epoll_fd, events, 2, -1);
        if (num_fds == -1) {
            perror("epoll_wait");
            exit(EXIT_FAILURE);
        }

        char line[128];
        ssize_t data;

        for (int i = 0; i < num_fds; i++) {
            int fd = events[i].data.fd;
            if (fd == fd0) {
                data = read(fd0, line, sizeof(line) - 1);
                if (data > 0) {
                    line[data] = '\0';
                    printf("Message from client0: %s\n", line);
                }
            } else if (fd == fd1) {
                data = read(fd1, line, sizeof(line) - 1);
                if (data > 0) {
                    line[data] = '\0';
                    printf("Message from client1: %s\n", line);
                }
            }
        }
    }

    return 0;
}
