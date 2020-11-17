##
## EPITECH PROJECT, 2020
## B-CPE-110-NCY-1-1-BSQ-sebastien.raoult
## File description:
## Makefile
##

NAME      = bsq

CC        = gcc -g

RM        = rm -f

SRCS      = $(wildcard ./*.c) $(wildcard ./src/*.c) $(wildcard ./src/*/*.c)

T_SRCS    = $(wildcard ./tests/*.c)

OBJS      = $(SRCS:.c=.o)

T_OBJS    = $(T_SRCS:.c=.o)

CFLAGS 	  += -I ./include -Wall -Wextra

LDFLAGS   += -L ./lib/my -lmy
T_LDFLAGS += -lcriterion $(LDFLAGS)

all: $(NAME)

$(NAME): $(OBJS)
	 $(MAKE) -C ./lib/my
	 $(CC) $(OBJS) -o $(NAME) $(LDFLAGS)

clean:
	$(RM) $(OBJS)
	$(RM) $(T_OBJS)
	$(MAKE) -C ./lib/my clean

fclean: clean
	$(RM) $(NAME)
	$(RM) unit_tests
	$(MAKE) -C ./lib/my fclean

re: fclean all

unit_tests: re $(T_OBJS)
	$(CC) $(OBJS) $(T_OBJS) -o unit_tests --coverage $(T_LDFLAGS)

run_tests: all
	./unit_tests

.PHONY: all clean fclean re unit_tests run_tests
