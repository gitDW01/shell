#!/bin/bash
# 1st arg == requests number
# 2nd arg == url for wget
mkdir ./trash
for ((i=1; i<=$1; i++))
do
(time (wget -P ./trash $2 > /dev/null 2>&1) 2>&1) | grep real >> log.txt &
done
wait
rm -rf ./trash
