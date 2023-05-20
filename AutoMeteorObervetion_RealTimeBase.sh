#!/bin/sh

TIME=600
#SRATE=240000
SRATE=120000

TYPE=$1
DATE_min_ss=$2

if [ $TYPE -eq 1 ]; then
	FILE=FILE1.raw
	Spectrogram=spectrogram1.dat
	Meteor_intensity=Meteor_intensity1.dat
else
	FILE=FILE2.raw
	Spectrogram=spectrogram2.dat
	Meteor_intensity=Meteor_intensity2.dat
fi
#echo $FILE
#echo $Spectrogram
#echo $Meteor_intensity
#echo $DATE_min_ss

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
	DATE=$DATE$DATE_min_ss
	DATEWrite=`date '+%Y/%m/%d %H:'`
	DATEWrite=$DATEWrite$DATE_min_ss
	DATE_base=`date '+%H:'`
	DATE_base=$DATE_base$DATE_min_ss
fi

echo $DATE
echo "Now Observation"
#10min
#echo "FILE1.raw\n$DATE\n$DATEWrite\n$DATE_base" > flag.txt
TIME_Observ=`expr 600 - $zero_t`
#rec -q /home/kunitofukuda/WorkSpace/Meteor/data/FILE1.raw rate 2.4k channels 1 gain 10 trim 0 $TIME_Observ &
#rec -q /home/kunitofukuda/WorkSpace/Meteor/data/FILE1.raw rate 24k channels 1 gain 10 trim 0 $TIME_Observ &
#rec -q /home/kunitofukuda/WorkSpace/Meteor/data/FILE1.raw rate $SRATE channels 1 gain 10 trim 0 $TIME_Observ &

#########################################start2
#rec -q /tmp/FILE1.raw rate $SRATE channels 1 gain 10 trim 0 $TIME_Observ &
rec -q /tmp/$FILE rate $SRATE channels 1 gain 10 trim 0 $TIME_Observ &
#########################################end2

#Real time
N=`expr 599 - $zero_t`
cp spectrogram_RealTime_v2.plt ttt.plt
sed -i "s/outputfile/$DATE/g" ttt.plt
sed -i "s|writetime|$DATEWrite|g" ttt.plt
sed -i "s/zero_t/$zero_t/g" ttt.plt
sed -i "s/loop_number/$N/g" ttt.plt
#########################################start3
#sed -i "s/spectrogram.dat/spectrogram1.dat/g" ttt.plt
sed -i "s/spectrogram.dat/$Spectrogram/g" ttt.plt
#########################################start3

for i in 10 9 8 7 6 5 4 3 2 1 0; do
DATE_add=`date -d "$DATE_base $i minute" "+%H:%M"`

sed -i "s/t$i/$DATE_add/g" ttt.plt
done

sleep 3
#gnuplot ttt.plt &

fpStart=0
#N=599

echo "calc..."
#./fftw3_spectrogram_Realtime ./data/FILE1.raw 0 > spectrogram1.dat
#########################################start4
#rm /tmp/spectrogram1.dat
#touch /tmp/spectrogram1.dat
rm /tmp/$Spectrogram
touch /tmp/$Spectrogram
#########################################end4

#echo `seq 1 $N`

#for i in `seq 1 $N`; do
for i in `seq 0 $N`; do

#fpStart=`expr $i \* 2400`
fpStart=`expr $i \* $SRATE`
#echo "$i $fpStart"
#./fftw3_spectrogram_Realtime ./data/FILE1.raw $fpStart >> spectrogram1.dat
#########################################start5
#./fftw3_spectrogram_Realtime_v2 /tmp/FILE1.raw $fpStart >> /tmp/spectrogram1.dat
./fftw3_spectrogram_Realtime /tmp/$FILE $fpStart >> /tmp/$Spectrogram
#########################################end5
#sleep 1
#sleep 0.5

done

#########################################start6
#./block_sum /tmp/spectrogram1.dat > /tmp/Meteor_intensity1.dat
./block_sum /tmp/$Spectrogram > /tmp/$Meteor_intensity
#########################################end6

echo "graph..."
#cp spectrogram_v3.plt ttt_output.plt
cp spectrogram_v5.plt ttt_output.plt
sed -i "s/outputfile/$DATE/g" ttt_output.plt
sed -i "s|writetime|$DATEWrite|g" ttt_output.plt
sed -i "s/zero_t/$zero_t/g" ttt_output.plt
#########################################start7
#sed -i "s/spectrogram.dat/spectrogram1.dat/g" ttt_output.plt
#sed -i "s/Meteor_intensity.dat/Meteor_intensity1.dat/g" ttt_output.plt
sed -i "s/spectrogram.dat/$Spectrogram/g" ttt_output.plt
sed -i "s/Meteor_intensity.dat/$Meteor_intensity/g" ttt_output.plt
#########################################end7

for i in 10 9 8 7 6 5 4 3 2 1 0; do
DATE_add=`date -d "$DATE_base $i minute" "+%H:%M"`

sed -i "s/t$i/$DATE_add/g" ttt_output.plt
done
gnuplot ttt_output.plt
sleep 5

echo "end"

#done
