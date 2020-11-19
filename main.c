/*
** EPITECH PROJECT, 2020
** B-CPE-110-NCY-1-1-BSQ-sebastien.raoult
** File description:
** main
*/

#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "bsq.h"

static int check_board(char * const *board)
{
    int size = (*board != NULL && my_str_isnum(*board)) ?
                my_getnbr(*board) : 0;
    int i = 0;
    int j = 0;
    int length = 0;

    length = my_strlen(board[1]);
    for (i = 1; board[i]; i++) {
        for (j = 0; board[i][j]; j++)
            if (board[i][j] != 'o' && board[i][j] != '.')
                return (0);
        if (length != j)
            return (0);
    }
    if (size == 0 || size != i - 1)
        return (0);
    return (find_the_biggest_square(board + 1, length, size));
}

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
    char **board = NULL;

    if (argc != 2)
        return (84);
    buffer = fs_open_file(argv[1]);
    if (buffer == NULL)
        return (84);
    board = my_str_to_wordtab(buffer, '\n');
    free(buffer);
    if (board == NULL || !check_board(board)) {
        if (board != NULL)
            free_double_array((void ***)&board);
        return (84);
    }
    free_double_array((void ***)&board);
    return (0);
}
