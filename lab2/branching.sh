#!/bin/bash

if [[ -z $1 ]]; then
    echo "Ошибка: Укажите число в качестве аргумента."
    echo "Пример: $0 5"
    exit 1
fi

num=$1

if [[ $num -gt 0 ]]; then
    echo "Число $num положительное."
elif [[ $num -lt 0 ]]; then
    echo "Число $num отрицательное."
else
    echo "Число равно нулю."
fi
