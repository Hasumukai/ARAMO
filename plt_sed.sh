#!/bin/sh

main_path=$1
filename=$2

str=`cat $main_path/obs_setting.txt | # 挿入する文字列を読み込み
        sed -r 's/$/\\\FFF /' | # 各行の末端に改行文字を入れる
        sed -r '$s/\\\\n//' | # 最終行の改行文字に関しては必要ないので取り除く
        while IFS= read -r line # 1行ずつ読み込み
        do
            echo -n "$line" # echo -nで各行を改行しないで出力->1行にまとめる
        done`

sed -i "s/obs_setting/$str/g" $filename
sed -i "s/FFF/\\\\n/g" $filename
