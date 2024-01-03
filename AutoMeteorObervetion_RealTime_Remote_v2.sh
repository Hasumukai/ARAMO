#!/bin/sh

freq_base=$1
cal_sym=$2
freq_diff=$3
/home/dietpi/workspace/meteor/WaveMeasure/AutoMeteorObervetion_rtl-sdr_v3.sh $freq_base $cal_sym $freq_diff &

/home/dietpi/workspace/meteor/WaveMeasure/AutoMeteorObervetion_RealTime1_v4.sh $freq_base $cal_sym $freq_diff &
/home/dietpi/workspace/meteor/WaveMeasure/AutoMeteorObervetion_RealTime2_v4.sh $freq_base $cal_sym $freq_diff

#echo "end"
