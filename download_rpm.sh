#!/bin/bash
#download rpm from list in file $1
for i in `cat ./$1`
do
yumdownloader $i
done

