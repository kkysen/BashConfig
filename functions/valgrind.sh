function valgrind() {
    command valgrind --leak-check=full --show-leak-kinds=all ${@}
}

export -f valgrind
