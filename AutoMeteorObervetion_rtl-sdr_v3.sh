#!/bin/sh

if [ $# -ne 3 ]; then 
	echo "error"
	exit 1

fi

#freq_base=89.4
#freq_diff=780
freq_base=$1	#89.4 MHz
cal_sym=$2	#+ or -
freq_diff=$3	#780 Hz

echo "$freq_base MHz $cal_sym $freq_diff Hz"
#echo " $(($freq_base - $freq_diff)) "
freq=`echo "$freq_base * 1000000 $cal_sym $freq_diff" | bc -l`
echo "$freq"

rtl_fm -f $freq -M usb -s 200k -r 48k | aplay -r 48000 -f s16_LE
#rtl_fm -f $freq -M cw -s 200k -r 48k | aplay -r 48000 -f s16_LE
