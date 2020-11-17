/*
** EPITECH PROJECT, 2020
** B-CPE-110-NCY-1-1-BSQ-sebastien.raoult
** File description:
** bsq
*/

#include <stdio.h>
#include "bsq.h"

static void print_bsq(char * const *board, int corner, int max_i, int max_j)
{
    for (int i = max_i; i > max_i - corner; i--)
        for (int j = max_j; j > max_j - corner; j--)
            board[i][j] = 'x';
    my_show_word_array(board);
}

static int min(int a, int b, int c)
{
    int m = a;

    if (m > b)
        m = b;
    if (m > c)
        m = c;
    return (m);
}

static short **copy_board(char * const *board, int width, int height)
{
    short **cpy_board = NULL;

    cpy_board = malloc(sizeof(short *) * (height + 1));
    for (int i = 0; i < height; i++)
        cpy_board[i] = malloc(sizeof(short) * (width + 1));
    for (int i = 0; i < height; i++)
        cpy_board[i][0] = (board[i][0] == 'o') ? 0 : 1;
    for (int j = 0; j < width; j++)
        cpy_board[0][j] = (board[0][j] == 'o') ? 0 : 1;
    for (int i = 1; i < height; i++)
        for (int j = 1; j < width; j++)
            if (board[i][j] == '.')
                cpy_board[i][j] = min(cpy_board[i][j - 1], cpy_board[i - 1][j],
                                        cpy_board[i - 1][j - 1]) + 1;
            else
                cpy_board[i][j] = 0;
    cpy_board[height] = NULL;
    return (cpy_board);
}

int find_the_biggest_square(char * const *board, int width, int height)
{
    int corner = 0;
    int max_i = 0;
    int max_j = 0;
    short **cpy_board = copy_board(board, width, height);

    if (!cpy_board)
        return (0);
    corner = cpy_board[0][0];
    for (int i = 0; i < height; i++)
        for (int j = 0; j < width; j++)
            if (corner < cpy_board[i][j]) {
                corner = cpy_board[i][j];
                max_i = i;
                max_j = j;
            }
    free_double_array((void ***)&cpy_board);
    print_bsq(board, corner, max_i, max_j);
    return (1);
}
