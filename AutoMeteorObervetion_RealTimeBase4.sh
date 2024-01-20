#!/bin/sh

#v4:
#図のpythonプログラムで書く方式に変更
#パスをまとめる -> main_path

TIME=600
SRATE=120000

TYPE=$1
DATE_min_ss=$2
freq_base=$3
cal_sym=$4
freq_diff=$5
main_path=$6

#main_path=/home/dietpi/workspace/meteor/WaveMeasure

echo "$freq_base MHz $cal_sym $freq_diff Hz"

if [ $TYPE -eq 1 ]; then
	FILE=FILE1.raw
	Spectrogram=spectrogram1.dat
	Meteor_intensity=Meteor_intensity1.dat
else
	FILE=FILE2.raw
	Spectrogram=spectrogram2.dat
	Meteor_intensity=Meteor_intensity2.dat
fi

#set wake up time
DATE_sec=0

Wake_DATE=$((DATE_min_ss*60+DATE_sec))

DATE_min=`date '+%M'`
DATE_sec=`date '+%S'`
Now_DATE=`expr $DATE_min \* 60 + $DATE_sec`

sleep_t=`expr $Wake_DATE - $Now_DATE`
echo $sleep_t
if [ $sleep_t -gt 0 ]; then
	sleep $sleep_t
	zero_t=0
	DATE=`date '+%Y%m%d%H%M'`
	DATEWrite=`date '+%Y/%m/%d %H:%M'`
	DATE_base=`date '+%H:%M'`
else
	zero_t=`expr $Now_DATE - $Wake_DATE `
	echo "$zero_t "
	DATE=`date '+%Y%m%d%H'`
#	DATE=`date '+%Y%m%d%H%M'`
	DATE=$DATE$DATE_min_ss
	DATEWrite=`date '+%Y/%m/%d %H:'`
	DATEWrite=$DATEWrite$DATE_min_ss
	DATE_base=`date '+%H:'`
#	DATE_base=`date '+%H:%M'`
	DATE_base=$DATE_base$DATE_min_ss
fi

folder=`date '+%Y%m%d'`
echo $DATE
echo "Now Observation"
#10min
TIME_Observ=`expr 600 - $zero_t`

rec -q /tmp/$FILE rate $SRATE channels 1 gain 10 trim 0 $TIME_Observ &

#Real time
N=`expr 599 - $zero_t`
##cp ~/workspace/meteor/spectrogram_RealTime_v2.plt /tmp/ttt.plt
##cp /home/dietpi/workspace/meteor/WaveMeasure/spectrogram_RealTime_v2.plt /tmp/ttt.plt
#cp $main_path/spectrogram_RealTime_v2.plt /tmp/ttt.plt
#sed -i "s/outputfile/$DATE/g" /tmp/ttt.plt
#sed -i "s|writetime|$DATEWrite|g" /tmp/ttt.plt
#sed -i "s/zero_t/$zero_t/g" /tmp/ttt.plt
#sed -i "s/loop_number/$N/g" /tmp/ttt.plt
#sed -i "s/spectrogram.dat/$Spectrogram/g" /tmp/ttt.plt
#
#for i in 10 9 8 7 6 5 4 3 2 1 0; do
#DATE_add=`date -d "$DATE_base $i minute" "+%H:%M"`
#
#sed -i "s/t$i/$DATE_add/g" /tmp/ttt.plt
#done

sleep 3
#gnuplot ttt.plt &

fpStart=0

echo "calc..."
rm /tmp/$Spectrogram
touch /tmp/$Spectrogram

for i in `seq 0 $N`; do

fpStart=`expr $i \* $SRATE`
#echo "$i $fpStart"
$main_path/fftw3_spectrogram_Realtime /tmp/$FILE $fpStart >> /tmp/$Spectrogram
#/home/dietpi/workspace/meteor/WaveMeasure/fftw3_spectrogram_Realtime /tmp/$FILE $fpStart >> /tmp/$Spectrogram
#/home/dietpi/workspace/meteor/WaveMeasure/fftw3_spectrogram_Realtime_wide /tmp/$FILE $fpStart >> /tmp/$Spectrogram
#/home/dietpi/workspace/meteor/WaveMeasure/fftw3_spectrogram_Realtime /tmp/$FILE $fpStart >> /tmp/$Spectrogram

done
#/home/dietpi/workspace/meteor/WaveMeasure/block_sum /tmp/$Spectrogram > /tmp/$Meteor_intensity
$main_path/block_sum /tmp/$Spectrogram > /tmp/$Meteor_intensity
#~/workspace/meteor/block_sum /tmp/$Spectrogram > /tmp/$Meteor_intensity

echo "graph..."
echo "$DATEWrite"
#cp $main_path/plot_plt_v0.2.py /tmp/ttt_output.py
cp $main_path/plt_v0.2.py /tmp/ttt_output.py
#cp $main_pass/spectrogram_v10.plt /tmp/ttt_output.plt
#cp /home/dietpi/workspace/meteor/WaveMeasure/spectrogram_v10.plt /tmp/ttt_output.plt
#cp /home/dietpi/workspace/meteor/WaveMeasure/spectrogram_v10.plt /tmp/ttt_output.plt
#cp /home/dietpi/workspace/meteor/WaveMeasure/spectrogram_v9.plt /tmp/ttt_output.plt
sed -i "s/folder/$folder/g" /tmp/ttt_output.py
sed -i "s/freq_base/$freq_base/g" /tmp/ttt_output.py
sed -i "s/cal_sym/$cal_sym/g" /tmp/ttt_output.py
sed -i "s/freq_diff/$freq_diff/g" /tmp/ttt_output.py
sed -i "s/outputfile/$DATE/g" /tmp/ttt_output.py
sed -i "s|writetime|$DATEWrite|g" /tmp/ttt_output.py
#sed -i "s:writetime/$DATEWrite:g" /tmp/ttt_output.py
sed -i "s/zero_t/$zero_t/g" /tmp/ttt_output.py
sed -i "s/spectrogram.dat/$Spectrogram/g" /tmp/ttt_output.py
sed -i "s/Meteor_intensity.dat/$Meteor_intensity/g" /tmp/ttt_output.py
sed -i "s|main_path|$main_path|g" /tmp/ttt_output.py
sed -i "s/folder/$folder/g" /tmp/ttt_output.py
sed -i "s/OFFSET_TIME/$zero_t/g" /tmp/ttt_output.py

#for i in 10 9 8 7 6 5 4 3 2 1 0; do
for i in 9 8 7 6 5 4 3 2 1; do
DATE_add=`date -d "$DATE_base $i minute" "+%H:%M"`

#sed -i "s/t$i/$DATE_add/g" /tmp/ttt_output.plt
sed -i "s/t$i/$DATE_add/g" /tmp/ttt_output.py
done

#################################################
cp /home/dietpi/workspace/meteor/WaveMeasure/spectrogram_v10.plt /tmp/ttt_output.plt
sed -i "s/folder/$folder/g" /tmp/ttt_output.plt
sed -i "s/freq_base/$freq_base/g" /tmp/ttt_output.plt
sed -i "s/cal_sym/$cal_sym/g" /tmp/ttt_output.plt
sed -i "s/freq_diff/$freq_diff/g" /tmp/ttt_output.plt
sed -i "s/outputfile/$DATE/g" /tmp/ttt_output.plt
sed -i "s|writetime|$DATEWrite|g" /tmp/ttt_output.plt
sed -i "s/zero_t/$zero_t/g" /tmp/ttt_output.plt
sed -i "s/spectrogram.dat/$Spectrogram/g" /tmp/ttt_output.plt
sed -i "s/Meteor_intensity.dat/$Meteor_intensity/g" /tmp/ttt_output.plt

for i in 10 9 8 7 6 5 4 3 2 1 0; do
	DATE_add=`date -d "$DATE_base $i minute" "+%H:%M"`

	sed -i "s/t$i/$DATE_add/g" /tmp/ttt_output.plt
done

if [ -d "~/workspace/meteor/meteor/WaveMeasure/data/$folder" ]; then
	echo "save $DATE.png in $folder."
else
	mkdir /home/dietpi/workspace/meteor/WaveMeasure/data/$folder
#	mkdir ~/workspace/meteor/data/$folder
	echo "make directory $folder."
fi

gnuplot /tmp/ttt_output.plt
sleep 5
#################################################

#if [ -d "~/workspace/meteor/data/$folder" ]; then
if [ -d "$main_path/data/$folder" ]; then
	echo "save $DATE.png in $folder."
else
#mkdir /home/dietpi/workspace/meteor/WaveMeasure/data/$folder
	mkdir $main_path/data/$folder
#	mkdir /home/dietpi/workspace/meteor/WaveMeasure/data/$folder
#	mkdir ~/workspace/meteor/data/$folder
	echo "make directory $folder."
fi

#gnuplot /tmp/ttt_output.plt
python3 /tmp/ttt_output.py
sleep 5

echo "end"
