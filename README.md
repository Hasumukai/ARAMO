# KROFFT
SDRを用いてLinux系で電波流星観測を記録するためのシステム

1.概要
本内容は、
Software Defined Radio (SDR)を用いた
Linux系で電波流星観測をするためのシステムです。
観測結果が画像として保存されます。
"202305162330.png"が観測例です。

基本的にLinuxの既存ソフトウェアを
利用する方針で構築しています。
そのため、プログラム部分が少なく
変更等が容易かと思います。
自由に編集し、利用ください。


2.動作環境
SDR(RTL2832U)が動くLinux環境で動作するかと思います。
以下の環境で動作を確認しています。

Hardware
	Raspberry Pi 4B
	RTL2832U+R820T(RTL-SDR)
	Loop antena
OS
	DietPi v8.17.2
Software
	rtl_sdr
	Gnuplot

3.電波流星観測を行う前に
3.1.必要なソフトウェアのインストール
以下のパッケージは少なくともインストールしてください。
gnuplot rtl_sdr libfftw3-dev

3.2.SDR動作の確認
SDRが正常に動作するか確認ください。
FMラジオを聴けるか流星電波観測をする前に
確認しましょう。

3.3.ディレクトリ構造
以下のディレクトリ構造を想定してます。
~/Meteor
  |-AutoMeteorObservetion_rtl-sdr.sh
  |-AutoMeteorObservetion_Realtime1_v1.sh
  |-AutoMeteorObservetion_Realtime2_v1.sh
  |-AutoMeteorObservetion_RealtimeBase.sh
  |-fftw3_spectrogram_Realtime.c
  |-block_sum.c
  |-spectrogram_Realtime_v2.plt
  |-spectrogram_v5.plt
  |-data
     |-画像が保存される

また、/tmpディレクトリが存在することを想定しています。
注意
観測データの書き込みは大量のデータを高頻度で行います。
そのため観測データを/tmpディレクトリに保存せず、
不揮発メモリ(HDD、SSD、SDカード等)に保存すると、
不揮発メモリの寿命を縮めます。

3.4.プログラムのコンパイル
C言語のプログラムをコンパイルしてください。
gcc -o block_sum.c block_sum
gcc -o fftw3_spectrogram_Realtime.c fftw3_spectrogram_Realtime -lm -lfftw3

4.設定
4.1.観測画像テキストの編集
測定結果の画像の上部のテキストは、
以下のgnuplotファイルを編集して記入してください。
spectrogram_v5.plt
ご自身の観測環境に応じて記入ください。
label4~7が対応します。

4.2.観測周波数の設定
観測する周波数や観測モードは、以下のプログラムで設定しています。
AutoMeteorObservetion_rtl-sdr.sh
観測前に適宜、設定してください。
利用する周波数は、ネット等で検索して選択ください。

4.3.観測範囲の設定
以下のCプログラムで観測する範囲を設定しています。
fftw3_spectrogram_Realtime.c
初期設定は、START_FREQ(700Hz)からEND_FREQ(1100Hz)の範囲です。
最初に観測する周波数を決定するためには、
広域に設定するのがよろしいかとお思います。
適宜、2つのパラメータを設定して観測してください。
ただし、範囲を広げるほどフーリエ変換の処理が重くなりますので
注意してください。

"5.測定手順"を実行して、観測します。

流星と思われる信号が得られたら、
近隣の電波流星観測のライブと比較し
確認するとよいかと思います。
ただし、常に同じ流星すべてが観測できるわけではないので注意してください。

流星が安定して観測できる周波数を確定出来たら、
それをもとに観測周波数と観測範囲を再設定し
連続測定に移行しましょう。

4.4.連続測定
連続測定では、
日周期の観測で安定性が確認できます。

連続測定が確認できましたら
ご自身の興味のあるようにご利用ください。

5.測定手順
以下の順番にプログラムを起動する。

5.1.SDRの起動
./AutoMeteorObservetion_rtl-sdr.sh

5.2.観測プログラムの起動
別の端末２つでそれぞれ以下を実行する。
./AutoMeteorOBservation_Realtime1_v2.sh
./AutoMeteorOBservation_Realtime2_v2.sh

プログラムが正常に動作した場合は、
dataディレクトリ内部に10分ごとに画像が生成されます。

6.謝辞
本測定システムは、
Windows系で利用されているHROFFTとMROFFTを
参考に作製しました。
両ソフトを作製された先人たちに感謝いたします。

また、Linux系での測定系は、
MroSpecの公開資料が大いに参考なりました。
ありがとうございます。
ARMマイコンで動作するプログラムとして、
先行してらっしゃいます。
観測ビューワ（MroView）等の便利なものも作成されており
こちらも確認いただければ観測方法の理解が深まり、
改造等の参考になるかと思います。
