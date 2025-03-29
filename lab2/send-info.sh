#!/bin/bash
password="123"
remote_server="vanya@192.168.0.110:/home/vanya/results"
local_dir="/home/lab2/results/*"
sshpass -p "$password" scp $local_dir "$remote_server"
echo "Файлы успешно перенесены на сервер!"
