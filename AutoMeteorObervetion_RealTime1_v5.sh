#!/bin/sh

#0 20 40min

freq_base=$1
cal_sym=$2
freq_diff=$3
main_path=$4

while :
do

DATE_min=`date '+%M'`
echo "$DATE_min min"

if [ $DATE_min -ge 50 ]; then
	DATE_min=60 #wait
	echo "60 wait"
elif [ $DATE_min -ge 40 ]; then
	DATE_min=40 #soon
	echo "40 soon"
elif [ $DATE_min -ge 30 ]; then
	DATE_min=40 #wait
	echo "40 wait"
elif [ $DATE_min -ge 20 ]; then
	DATE_min=20 #soon
	echo "20 soon"
elif [ $DATE_min -ge 10 ]; then
	DATE_min=20 #wait
	echo "20 wait"
else
	DATE_min=0 #soon
	echo "0 soon"
fi

DATE_min_ss=$DATE_min

#~/workspace/meteor/AutoMeteorObervetion_RealTimeBase2.sh 1 $DATE_min $freq_base $freq_diff
#/home/dietpi/workspace/meteor/WaveMeasure/AutoMeteorObervetion_RealTimeBase3.sh 1 $DATE_min $freq_base $cal_sym $freq_diff
$main_path/AutoMeteorObervetion_RealTimeBase4.sh 1 $DATE_min $freq_base $cal_sym $freq_diff $main_path

done
