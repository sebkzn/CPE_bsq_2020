#!/bin/bash
##
## EPITECH PROJECT, 2020
## BSQ
## File description:
## tests
##

tests_verbose() {
    for map in $(ls ./mouli_maps); do
        i=$(expr $i + 1)
        if [[ $i -ne 1 ]]; then echo -ne "\n"; fi
        echo -e "\e[33mRunning ./bsq $map ...\e[39m"
        if diff <(valgrind ../bsq ./mouli_maps/${map} 2> valgrind.txt) ./mouli_maps_solved/${map} > /dev/null 2>&1; then
            cat valgrind.txt | grep --color=never 'ERROR\|heap usage'
            echo -e "$map: \e[92mtest success.\e[39m"
        else
            cat valgrind.txt | grep --color=never 'ERROR\|heap usage'
            echo -e "$map: \e[91mtest failed.\e[39m"
        fi
        rm -f valgrind.txt
    done
}

tests() {
    for map in $(ls ./mouli_maps); do
        i=$(expr $i + 1)
        if [[ $i -ne 1 ]]; then echo -ne "\n"; fi
        echo -e "\e[33mRunning ./bsq $map ...\e[39m"
        if diff <(../bsq ./mouli_maps/${map}) ./mouli_maps_solved/${map} > /dev/null 2>&1; then
            echo -e "$map: \e[92mtest success.\e[39m"
        else
            echo -e "$map: \e[91mtest failed.\e[39m"
        fi
        rm -f valgrind.txt
    done
}

{ make -C ../ fclean && make -C ../; } > /dev/null 2>&1 || { echo "error when compilation" >&2; exit 84; }
if [[ $1 == "-v" || $1 == "--verbose" ]]; then
    tests_verbose
else
    tests
fi
