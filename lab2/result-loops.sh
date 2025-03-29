#!/bin/bash
# Разбор аргументов
while getopts "n:" opt; do
  case $opt in
    n) number="$OPTARG" ;;
    *) echo "Использование: $0 -n <число>"; exit 1 ;;
  esac
done
# Проверка ввода
if ! [[ "$number" =~ ^[0-9]+$ ]]; then
  echo "Ошибка: Введите неотрицательное целое число." > /home/lab2/results/result_loops.txt
  exit 1
fi
# Вычисление факториала через цикл
factorial=1
for (( i=1; i<=number; i++ )); do
  factorial=$((factorial * i))
done
# Запись в файл
echo "Факториал $number! = $factorial" > /home/lab2/results/result_loops.txt
echo "Результат сохранен в /home/lab2/results/result_loops.txt"
