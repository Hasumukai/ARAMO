#!/bin/sh

#freq=96.99900e6
freq=89.39912e6
echo $freq

rtl_fm -f $freq -M usb -s 200k -r 48k | aplay -r 48000 -f s16_LE
