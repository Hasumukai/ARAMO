#!/bin/sh

#10 30 50min

while :
do

DATE_min=`date '+%M'`
echo "$DATE_min"

if [ $DATE_min -ge 50 ]; then
	DATE_min=50 #soon
	echo "50 soon"
elif [ $DATE_min -ge 40 ]; then
	DATE_min=50 #wait
	echo "50 wait"
elif [ $DATE_min -ge 30 ]; then
	DATE_min=30 #soon
	echo "30 soon"
elif [ $DATE_min -ge 20 ]; then
	DATE_min=30 #wait
	echo "30 wait"
elif [ $DATE_min -ge 10 ]; then
	DATE_min=10 #soon
	echo "10 soon"
else
	DATE_min=10 #wait
	echo "10 wait"
fi
#DATE_min_ss=$DATE_min

./AutoMeteorObervetion_RealTimeBase.sh 2 $DATE_min

done
