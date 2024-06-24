#!/bin/bash

folder=$1
echo $folder
outputfile=$2
echo $outputfile
month_dir=${outputfile:0:6}
echo $month_dir

port=
keyPath=
userName=
hostName=

sftp -P $port -i $keyPath $userName@$hostName << EOF

#ホーム側：画像のディレクトリに移動
lcd $main_path/data/$folder

# サーバー側：ディレクトリへ移動
cd public_html/88.1MHz

mkdir $month_dir
cd $month_dir

mkdir $folder
cd $folder

# サーバーからmacへファイルをダウンロードする
put $outputfile.png

# 終わり
EOF
