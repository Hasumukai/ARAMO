#!/bin/bash

folder=$1
echo $folder
#folder:20240605
outputfile=$2
echo $outputfile
#outputfile:202406050110
month_dir=${outputfile:0:6}
echo $month_dir
#month_dir:202406
main_path=$3

sftp -P 8022 -i ~/.ssh/myKey.pem r7715020@www1075.onamae.ne.jp << EOF

#ホーム側：画像のディレクトリに移動
lcd $main_path/data/$folder

# サーバー側：ディレクトリへ移動
cd public_html/hasumukai.com/star/img_radio/88.1MHz/

mkdir $month_dir
cd $month_dir
#mkdir 202406
#cd 202406

mkdir $folder
cd $folder
#mkdir 20240604
#cd 20240604

# サーバーからmacへファイルをダウンロードする
#put *.png
put $outputfile.png

# 終わり
EOF