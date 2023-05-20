#!/bin/sh

#freq=96.99900e6
freq=89.39912e6
echo $freq

rtl_fm -f $freq -M usb -s 200k -r 48k | aplay -r 48000 -f s16_LE

#rtl_fm -f 82.184M -M wbfm -s 200k -r 32000-| aplay -Dhw:0,0 -r 32 -f S16_LE
#rtl_fm -f 82e6 -M wbfm -s 200e3 -r 48e3 -| aplay -r 48000 -f s16_LE

#rtl_fm -f 97.0003e6 -g 49.6 -M cw -s 200k -r 48k | aplay -r 48000 -f s16_LE
#rtl_fm -f 97.000e6 -g 49.6 -M cw -s 200k -r 48k | aplay -r 48000 -f s16_LE

#rtl_fm -f 97e6 -M usb -s 200k -r 48k | aplay -r 48000 -f s16_LE
#rtl_fm -f 96.99918e6 -M usb -s 200k -r 48k | aplay -r 48000 -f s16_LE
#rtl_fm -f 96.99920e6 -M usb -s 200k -r 48k | aplay -r 48000 -f s16_LE
#rtl_fm -f 96.9994e6 -g 49.6 -M usb -s 200k -r 48k | aplay -r 48000 -f s16_LE
#rtl_fm -f 96.99965e6 -g 49.6 -M usb -s 200k -r 48k | aplay -r 48000 -f s16_LE
#rtl_fm -f 96.99944e6 -g 49.6 -M usb -s 200k -r 48k | aplay -r 48000 -f s16_LE
#rtl_fm -f 97.00060e6 -g 49.6 -M usb -s 200k -r 48k | aplay -r 48000 -f s16_LE
