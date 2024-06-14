#!/bin/sh

#freq_base=$1
#cal_sym=$2
#freq_diff=$3
start_freq=$1
end_freq=$2

#main_path=~/workspace/meteor/KROFFT
main_path=~/workspace/meteor/ARAMO

#$main_path/AutoMeteorObervetion_rtl-sdr_v3.sh $freq_base $cal_sym $freq_diff &
#$main_path/AutoMeteorObervetion_RealTime1_v5.sh $freq_base $cal_sym $freq_diff $main_path&
#$main_path/AutoMeteorObervetion_RealTime2_v5.sh $freq_base $cal_sym $freq_diff $main_path
$main_path/AutoMeteorObervetion_RealTime1_v6.sh $start_freq $end_freq $main_path&
$main_path/AutoMeteorObervetion_RealTime2_v6.sh $start_freq $end_freq $main_path

#/home/dietpi/workspace/meteor/WaveMeasure/AutoMeteorObervetion_rtl-sdr_v3.sh $freq_base $cal_sym $freq_diff &
#/home/dietpi/workspace/meteor/WaveMeasure/AutoMeteorObervetion_RealTime1_v4.sh $freq_base $cal_sym $freq_diff &
#/home/dietpi/workspace/meteor/WaveMeasure/AutoMeteorObervetion_RealTime2_v4.sh $freq_base $cal_sym $freq_diff

#echo "end"
