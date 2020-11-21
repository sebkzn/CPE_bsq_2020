#!/bin/bash
##
## EPITECH PROJECT, 2020
## BSQ
## File description:
## tests
##

SUCCESS="0"
FAILED="0"

errors_handling() {
    for f in $(ls ./errors_handling); do
        i=$(expr $i + 1)
        if [[ $i -ne 1 ]]; then echo -ne "\e[96m--\n\e[39m"; fi
        echo -e "\e[33mChecking $f ...\e[39m"
        valgrind ../bsq ./errors_handling/${f} 2> valgrind.txt
        return="$?"
        cat valgrind.txt | grep --color=never 'ERROR\|heap usage'
        if [[ $return -eq 84 ]]; then
            echo -e "$f: \e[92mtest success.\e[39m"
            SUCCESS=$(expr $SUCCESS + 1)
        else
            echo -e "$f: \e[91mtest failed.\e[39m"
            FAILED=$(expr $FAILED + 1)
        fi
        rm -f valgrind.txt
    done
    echo -e "\n"
}

tests_verbose() {
    for map in $(ls ./mouli_maps); do
        j=$(expr $j + 1)
        if [[ $j -ne 1 ]]; then echo -ne "\e[96m--\n\e[39m"; fi
        echo -e "\e[33mRunning ./bsq $map ...\e[39m"
        if diff <(valgrind ../bsq ./mouli_maps/${map} 2> valgrind.txt) ./mouli_maps_solved/${map} > /dev/null 2>&1; then
            cat valgrind.txt | grep --color=never 'ERROR\|heap usage'
            echo -e "$map: \e[92mtest success.\e[39m"
            SUCCESS=$(expr $SUCCESS + 1)
        else
            cat valgrind.txt | grep --color=never 'ERROR\|heap usage'
            echo -e "$map: \e[91mtest failed.\e[39m"
            FAILED=$(expr $FAILED + 1)
        fi
        rm -f valgrind.txt
    done
}

tests() {
    for map in $(ls ./mouli_maps); do
        j=$(expr $j + 1)
        if [[ $j -ne 1 ]]; then echo -ne "\e[96m--\n\e[39m"; fi
        echo -e "\e[33mRunning ./bsq $map ...\e[39m"
        if diff <(../bsq ./mouli_maps/${map}) ./mouli_maps_solved/${map} > /dev/null 2>&1; then
            echo -e "$map: \e[92mtest success.\e[39m"
            SUCCESS=$(expr $SUCCESS + 1)
        else
            echo -e "$map: \e[91mtest failed.\e[39m"
            FAILED=$(expr $FAILED + 1)
        fi
        rm -f valgrind.txt
    done
}

{ make -C ../ fclean && make -C ../; } > /dev/null 2>&1 || { echo "error when compilation" >&2; exit 84; }
errors_handling
if [[ $1 == "-v" || $1 == "--verbose" ]]; then
    tests_verbose
else
    tests
fi
echo -e "\n[ \e[34mTOTAL: $(expr $i + $j)\e[39m | \e[92mPASSED: $SUCCESS\e[39m | \e[91mFAILED: $FAILED\e[39m ]"
make -C ../ fclean > /dev/null 2>&1