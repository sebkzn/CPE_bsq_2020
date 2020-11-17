##
## EPITECH PROJECT, 2020
## CPool Day 10
## File description:
## makefile
##

NAME	  = libmy.a

CC	  = gcc -g

AR	  = ar rcs

RM	  = rm -f

SRCS	  = $(wildcard ./*.c) $(wildcard ./myprintf/*.c)

T_SRCS	  = $(wildcard ./tests/*.c)

OBJS	  = $(SRCS:.c=.o)

T_OBJS	  = $(T_SRCS:.c=.o)

CFLAGS	  += -I . -Wall -Wextra

LDFLAGS	  += -L . -lmy

T_LDFLAGS += -lcriterion $(LDFLAGS)

all: $(NAME)

$(NAME): $(OBJS)
	 $(AR) $(NAME) $(OBJS)

clean:
	$(RM) $(OBJS)
	$(RM) $(T_OBJS)

fclean: clean
	$(RM) $(NAME)
	$(RM) unit_tests

re: fclean all

unit_tests: re $(T_OBJS)
	$(CC) $(OBJS) $(T_OBJS) -o unit_tests --coverage $(T_LDFLAGS)

run_tests: all
	./unit_tests

.PHONY: all clean fclean re unit_tests run_tests
