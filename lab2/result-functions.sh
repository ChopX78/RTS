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
  echo "Ошибка: Введите неотрицательное целое число." > /home/lab2/results/result_functions.txt
  exit 1
fi
# Функция для вычисления факториала
factorial() {
  local num=$1
  if [ "$num" -eq 0 ] || [ "$num" -eq 1 ]; then
    echo 1
  else
    echo $((num * $(factorial $((num - 1)))))
  fi
}
# Вычисляем факториал и записываем в файл
result=$(factorial "$number")
echo "Факториал $number! = $result" > /home/lab2/results/result_functions.txt
echo "Результат сохранен в /home/lab2/results/result_functions.txt"
