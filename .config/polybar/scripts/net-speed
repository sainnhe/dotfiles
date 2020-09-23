#!/bin/sh

SLP=1 # output / sleep interval
IS_GOOD=0

# while true; do

LINE=`grep $1 /proc/net/dev | sed s/.*://`;
WIRELESS_RECEIVED1=`echo $LINE | awk '{print $1}'`
WIRELESS_TRANSMITTED1=`echo $LINE | awk '{print $9}'`
LINE=`grep $2 /proc/net/dev | sed s/.*://`;
WIRED_RECEIVED1=`echo $LINE | awk '{print $2}'`
WIRED_TRANSMITTED1=`echo $LINE | awk '{print $9}'`

sleep $SLP

LINE=`grep $1 /proc/net/dev | sed s/.*://`;
WIRELESS_RECEIVED2=`echo $LINE | awk '{print $1}'`
WIRELESS_TRANSMITTED2=`echo $LINE | awk '{print $9}'`
LINE=`grep $2 /proc/net/dev | sed s/.*://`;
WIRED_RECEIVED2=`echo $LINE | awk '{print $2}'`
WIRED_TRANSMITTED2=`echo $LINE | awk '{print $9}'`

INSPEED=$((($WIRELESS_RECEIVED2+$WIRED_RECEIVED2-$WIRELESS_RECEIVED1-$WIRED_RECEIVED1)/$SLP))
OUTSPEED=$((($WIRELESS_TRANSMITTED2+$WIRED_TRANSMITTED2-$WIRELESS_TRANSMITTED1-$WIRED_TRANSMITTED1)/$SLP))

# done

# printf "In: %12i KB/s | Out: %12i KB/s | Total: %12i KB/s\n" $(($INSPEED/1024)) $(($OUTSPEED/1024)) $((($INSPEED+$OUTSPEED)/1024)) ;
if [[ "$3" == "out" ]]; then
    printf "%i KB/s 祝\n" $(($INSPEED/1024)) ;
else
    printf " %i KB/s\n" $(($OUTSPEED/1024)) ;
fi
