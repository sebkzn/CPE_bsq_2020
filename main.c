/*
** EPITECH PROJECT, 2020
** B-CPE-110-NCY-1-1-BSQ-sebastien.raoult
** File description:
** main
*/

#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "my.h"

static char *fs_open_file(char const *filepath)
{
    struct stat info;
    int fd;
    char *buffer;

    if (stat(filepath, &info) == -1 || !(info.st_size))
        return (NULL);
    fd = open(filepath, O_RDONLY);
    if (fd == -1)
        return (NULL);
    buffer = malloc(sizeof(char) * info.st_size + 1);
    if (!buffer)
        return (NULL);
    if (read(fd, buffer, info.st_size) != info.st_size)
        return (NULL);
    buffer[info.st_size] = '\0';
    close(fd);
    return (buffer);
}

int main(int argc, char * const *argv)
{
    char *buffer = NULL;

    if (argc != 2)
        return (84);
    buffer = fs_open_file(argv[1]);
    if (buffer == NULL)
        return (84);
    my_putstr(buffer);
    free(buffer);
    return (0);
}
