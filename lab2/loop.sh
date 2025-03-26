#!/bin/bash

if [[ -z $1 ]]; then
    echo "Ошибка: Укажите число в качестве аргумента."
    echo "Пример: $0 5"
    exit 1
fi

num=$1
factorial=1

if [[ $num -lt 0 ]]; then
    echo "Факториал отрицательного числа не определён."
    exit 1
fi

for (( i=1; i<=num; i++ )); do
    factorial=$((factorial * i))
done

echo "Факториал $num равен $factorial"
