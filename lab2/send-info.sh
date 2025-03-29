#!/bin/bash
password="123"
remote_server="valery@192.168.0.116:/home/valery/results"
local_dir="/home/lab2/results/*"
sshpass -p "$password" scp $local_dir "$remote_server"
echo "Файлы успешно перенесены на сервер!"
