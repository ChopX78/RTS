#!/bin/bash

read -p "Введите число: " num

if [[ $num -gt 0 ]]; then
    echo "Число $num положительное."
elif [[ $num -lt 0 ]]; then
    echo "Число $num отрицательное."
else
    echo "Число равно нулю."
fi
