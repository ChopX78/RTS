#!/bin/bash

read -p "Введите число: " num

factorial=1

if [[ $num -lt 0 ]]; then
    echo "Факториал отрицательного числа не определён."
    exit 1
fi

for (( i=1; i<=num; i++ )); do
    factorial=$((factorial * i))
done

echo "Факториал $num равен $factorial"
