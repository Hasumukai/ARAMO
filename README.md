# KROFFT
 system using SDR for radio meteor observation on Linux.

1. Outline

This is a system using Software Defined Radio (SDR) for radio meteor observation on Linux systems.
The observation results are saved as an image.
An example observation is "202305162330.png".

The system is basically built with the policy of using existing Linux software.
Therefore, there are few program parts, and modifications may be easy.
Please feel free to edit and use it as you like.


2. Operating Environment

It is expected to work in a Linux environment where SDR (RTL2832U) runs.
We have confirmed that it works in the following environment.

Hardware
	Raspberry Pi 4B
	RTL2832U+R820T(RTL-SDR)
	Loop antena
OS
	DietPi v8.17.2
Software
	rtl_sdr
	Gnuplot

3. Before Radio Meteor Observation

3.1. Installation of necessary software

The following packages must be installed at least.
gnuplot rtl_sdr libfftw3-dev

3.2. Confirmation of SDR operation

Please check if SDR is working properly.
Before you start observing meteors, please check if you can listen to FM radio.

3.3. Directory structure

The following directory structure is assumed.
~/Meteor
  |-AutoMeteorObservetion_rtl-sdr.sh
  |-AutoMeteorObservetion_Realtime1_v1.sh
  |-AutoMeteorObservetion_Realtime2_v1.sh
  |-AutoMeteorObservetion_RealtimeBase.sh
  |-fftw3_spectrogram_Realtime.c
  |-block_sum.c
  |-spectrogram_Realtime_v2.plt
  |-spectrogram_v5.plt
  |-data
     |-images are saved

It is also assumed that the /tmp directory exists.
Caution
Observation data is written to a large amount of data at a high frequency.
Therefore, 
if you do not store observation data in the /tmp directory 
and save the observation data in non-volatile memory (HDD, SSD, SD card, etc.), 
it will shorten the life of the non-volatile memory.

3.4. Program Compilation

Compile the program in C language.
gcc -o block_sum.c block_sum
gcc -o fftw3_spectrogram_Realtime.c fftw3_spectrogram_Realtime -lm -lfftw3

4.Configuration

4.1. Edit observation image text

The text at the top of the measurement result image is,
edit in the following gnuplot file.
spectrogram_v5.plt
Please fill in the text according to your observing environment.
Label4~7 corresponds.

4.2. Observation frequency setting

Observation frequency and observation mode are set by the following programs.
AutoMeteorObservetion_rtl-sdr.sh
Please set them appropriately before observation.
Please select the frequency to be used by searching on the internet, etc.

4.3. Setting of observation range

The following C program is used to set the range to be observed.
fftw3_spectrogram_Realtime.c
The initial setting is the range from START_FREQ (700Hz) to END_FREQ (1100Hz).
To determine the frequency to observe first,
it is recommended to set a wide range of frequencies.
Set the two parameters accordingly.
Note, however, that the wider the range, 
the heavier the Fourier transform processing will be.

Observe by performing "5. Measurement Procedure".

If you get a signal that seems to be a meteor, 
compare it with the live radio meteor observation in the neighborhood and check it.
However, please note that not all meteors can be observed at all times.

Once you have determined the frequency at which you can observe meteors stably,
then resetting the observation frequency and range based on the frequency and range,
and move on to the continuous measurement.

4.4. Continuous Measurement

In continuous measurement,
the stability can be confirmed by observing the diurnal period.

Once the continuous measurement is confirmed,
please use it to your own interest.

5. Measurement procedure

Start the program in the following order.

5.1. Start SDR

. /AutoMeteorObservetion_rtl-sdr.sh

5.2. Start the observation program

Execute the following on two different terminals respectively.
. /AutoMeteorOBservation_Realtime1_v2.sh
. /AutoMeteorOBservation_Realtime2_v2.sh

If the program runs successfully,
inside the ~/Meteor/data directory, an image will be generated every 10 minutes.

6. Acknowledgements

This measurement system was fabricated with reference to
HROFFT and MROFFT used in Windows systems.
We would like to thank our predecessors who created both software packages.

I also found MroSpec's public documents to be of great help.
Thank you very much for the program that runs on ARM microcontrollers.
If you check it out, 
you will be able to deepen your understanding of the observation method 
and helpful for modification of the program.
