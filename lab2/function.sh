#!/bin/bash

factorial() {
    if [[ $1 -le 1 ]]; then
        echo 1
    else
        local temp=$(( $1 - 1 ))
        local res=$(factorial $temp)
        echo $(( $1 * res ))
    fi
}

if [[ -z $1 ]]; then
    echo "Ошибка: Укажите число в качестве аргумента."
    echo "Пример: $0 5"
    exit 1
fi

num=$1

if [[ $num -lt 0 ]]; then
    echo "Факториал отрицательного числа не определён."
    exit 1
fi

result=$(factorial $num)
echo "Факториал $num равен $result"
