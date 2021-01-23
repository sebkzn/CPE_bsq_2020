##
## EPITECH PROJECT, 2020
## B-CPE-110-NCY-1-1-BSQ-sebastien.raoult
## File description:
## Makefile
##

NAME      = bsq

CC        = gcc -g

RM        = rm -f

SRCS      = $(wildcard ./*.c) $(wildcard ./src/*.c) $(wildcard ./src/**/*.c)

OBJS      = $(SRCS:.c=.o)

CFLAGS 	  += -I ./include -Wall -Wextra

LDFLAGS   = -L ./lib/my
LDLIBS    = -lmy

all: $(NAME)

$(NAME): $(OBJS)
	 $(MAKE) -C ./lib/my
	 $(CC) $(CFLAGS) $(OBJS) -o $(NAME) $(LDFLAGS) $(LDLIBS)

clean:
	$(RM) $(OBJS)
	$(RM) $(T_OBJS)
	$(MAKE) -C ./lib/my clean

fclean: clean
	$(RM) $(NAME)
	$(RM) unit_tests
	$(MAKE) -C ./lib/my fclean

re: fclean all

.PHONY: all clean fclean re unit_tests run_tests


