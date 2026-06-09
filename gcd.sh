#!/bin/bash

# 引数の数が2つでない場合
if [ $# -ne 2 ]; then
       	echo "Error: 引数は2つ指定してください" 1>&2 
 	exit 1
fi


#引数が小数の場合
if [[ "$1" =~ \. || "$2" =~ \. ]]; then
        echo "Error: 引数は整数を入力してください" 1>&2
        exit 1
fi


#引数が数字以外の場合
expr $1 + $2 > /dev/null 2>&1 
if [ $? -ge 2 ]; then 
	echo "Error: 引数は数字を指定してください" 1>&2 
	exit 1 
fi


#引数が負の数の場合
if [[ "$1" -lt 1 || "$2" -lt 1 ]]; then
	echo "Error: 引数は正の数を入力してください" 1>&2
	exit 1
fi


#引数が極度の大きい場合
MAX=999999999

if [[ "$1" -gt "$MAX" || "$2" -gt "$MAX" ]]; then
	echo "Error: 引数が大きすぎます。9桁以内に収めてください" 1>&2
	exit 1
fi


#ユークリッドの互除法
a=$1
b=$2

while [ "$b" -ne 0 ]
do
	temp=$b
	b=$((a % b))
	a=$temp
done

echo "$a"
exit 0


