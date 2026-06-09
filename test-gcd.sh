#!/bin/bash

tmp=/tmp/$$ 
echo "Error: 引数は2つ指定してください" > $tmp-args 
echo "Error: 引数は整数を入力してください" > $tmp-nat 
echo "Error: 引数は数字を指定してください" > $tmp-type 
echo "Error: 引数は正の数を入力してください" > $tmp-val 
echo "Error: 引数が大きすぎます。9桁以内に収めてください" > $tmp-over

ERROR_EXIT () {
	echo "$1" >&2 # エラーメッセージ(引数1)を標準エラー出力に表示
	rm -f $tmp-* # 作ったファイルの削除
	exit 1 # エラー終了
}

#テスト開始
#test1-1：引数の数が足りない
./gcd.sh 2> $tmp-ans && ERROR_EXIT "error in test1-1-1"
diff $tmp-ans $tmp-args || ERROR_EXIT "error in test1-1-2"

#test1-2：引数の数が多い
./gcd.sh 13 4 25> $tmp-ans && ERROR_EXIT "error in test1-2-1"
diff $tmp-ans $tmp-args || ERROR_EXIT "error in test1-2-2"

#test2：引数が小数
./gcd.sh 5.6 3.2> $tmp-ans && ERROR_EXIT "error in test2-1"
diff $tmp-ans $tmp-nat || ERROR_EXIT "error in test2-2"

#test3：引数が文字
./gcd.sh aa ggg> $tmp-ans && ERROR_EXIT "error in test3-1"
diff $tmp-ans $tmp-type || ERROR_EXIT "error in test3-2"

#test4：引数が負の数
./gcd.sh -20 4> $tmp-ans && ERROR_EXIT "error in test4-1"
diff $tmp-ans $tmp-val || ERROR_EXIT "error in test4-2"

#test5：引数が10桁以上
./gcd.sh 2 12345678910> $tmp-ans && ERROR_EXIT "error in test5-1"
diff $tmp-ans $tmp-over || ERROR_EXIT "error in test5-2"

#test6-1：引数が正常
./gcd.sh 2 4> $tmp-result
echo "2" > $tmp-ans
diff $tmp-result $tmp-ans && echo "OK" || ERROR_EXIT "error in test6-1"
rm $tmp-result $tmp-ans

#test6-2：引数が正常
./gcd.sh 12 18> $tmp-result
echo "6" > $tmp-ans
diff $tmp-result $tmp-ans && echo "OK" || ERROR_EXIT "error in test6-2"
rm $tmp-result $tmp-ans

#test6-3：引数が正常
./gcd.sh 7 11> $tmp-result
echo "1" > $tmp-ans
diff $tmp-result $tmp-ans && echo "OK" || ERROR_EXIT "error in test6-3"
rm $tmp-result $tmp-ans

#test6-4：引数が正常
./gcd.sh 100 90> $tmp-result
echo "10" > $tmp-ans
diff $tmp-result $tmp-ans && echo "OK" || ERROR_EXIT "error in test6-4"
rm $tmp-result $tmp-ans

#test6-5：引数が正常
./gcd.sh 50 75> $tmp-result
echo "25" > $tmp-ans
diff $tmp-result $tmp-ans && echo "OK" || ERROR_EXIT "error in test6-5"
rm $tmp-result $tmp-ans


