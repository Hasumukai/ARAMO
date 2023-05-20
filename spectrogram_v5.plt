#!/usr/bin/gnuplot -persist
#
#    
#    	G N U P L O T
#    	Version 5.2 patchlevel 8    last modified 2019-12-01 
#    
#    	Copyright (C) 1986-1993, 1998, 2004, 2007-2019
#    	Thomas Williams, Colin Kelley and many others
#    
#    	gnuplot home:     http://www.gnuplot.info
#    	faq, bugs, etc:   type "help FAQ"
#    	immediate help:   type "help"  (plot window: hit 'h')
# set terminal qt 0 font "Sans,9"
# set output
unset clip points
set clip one
unset clip two
set errorbars front 1.000000 
set border 31 front lt black linewidth 1.000 dashtype solid
set zdata 
set ydata 
set xdata 
set y2data 
set x2data 
set boxwidth
set style fill  empty border
set style rectangle back fc  bgnd fillstyle   solid 1.00 border lt -1
set style circle radius graph 0.02 
set style ellipse size graph 0.05, 0.03 angle 0 units xy
set dummy x, y
set format x "% h" 
set format y "% h" 
set format x2 "% h" 
set format y2 "% h" 
set format z "% h" 
set format cb "% h" 
set format r "% h" 
set ttics format "% h"
set timefmt "%d/%m/%y,%H:%M"
set angles radians
set tics back
unset grid
unset raxis
set theta counterclockwise right
set style parallel front  lt black linewidth 2.000 dashtype solid
set key title "" center
set key fixed right top vertical Right noreverse enhanced autotitle nobox
set key noinvert samplen 4 spacing 1 width 0 height 0 
set key maxcolumns 0 maxrows 0
set key noopaque
unset label
unset arrow
set style increment default
unset style line
unset style arrow
set style histogram clustered gap 2 title textcolor lt -1
unset object
set style textbox transparent margins  1.0,  1.0 border  lt -1 linewidth  1.0
set offsets 0, 0, 0, 0
set pointsize 1
set pointintervalbox 1
set encoding default
unset polar
unset parametric
unset decimalsign
unset micro
unset minussign
set view map scale 1
#set view 0, 0, 1, 1
#set view azimuth 0
set rgbmax 255
set samples 100, 100
set isosamples 10, 10
set surface 
unset contour
set cntrlabel  format '%8.3g' font '' start 5 interval 20
set mapping cartesian
set datafile separator whitespace
unset hidden3d
set cntrparam order 4
set cntrparam linear
set cntrparam levels 5
set cntrparam levels auto
set cntrparam firstlinetype 0 unsorted
set cntrparam points 5
set size ratio 0 1,1
set origin 0,0
set style data pm3d
set style function pm3d
unset xzeroaxis
unset yzeroaxis
unset zzeroaxis
unset x2zeroaxis
unset y2zeroaxis
set xyplane relative 0.5
set tics scale  1, 0.5, 1, 1, 1
set mxtics default
set mytics default
set mztics default
set mx2tics default
set my2tics default
set mcbtics default
set mrtics default
set nomttics
set xtics border in scale 1,0.5 mirror norotate  autojustify
set xtics  norangelimit
set xtics  0,60,600
set x2tics border in scale 1,0.5 nomirror norotate  autojustify
set x2tics  norangelimit
set xtics textcolor rgb "yellow"
set x2tics textcolor rgb "yellow"
set x2tics 0,60,600
#set x2tics axis ("" 0, "23:31" 60, "23:32" 120, "23:33" 180, "23:34" 240, "23:35" 300, "23:36" 360, "23:37" 420, "23:38" 480, "23:39" 540, "" 600)
set ytics border in scale 1,0.5 mirror norotate  autojustify
set ytics  norangelimit autofreq 
set ztics border in scale 1,0.5 nomirror norotate  autojustify
set ztics  norangelimit autofreq 
#unset x2tics
unset y2tics
set cbtics border in scale 1,0.5 mirror norotate  autojustify
set cbtics  norangelimit autofreq 
set rtics axis in scale 1,0.5 nomirror norotate  autojustify
set rtics  norangelimit autofreq 
unset ttics
set title "" 
set title  font "" textcolor lt -1 norotate
set timestamp bottom 
set timestamp "" 
set timestamp  font "" textcolor lt -1 norotate
set trange [ * : * ] noreverse nowriteback
set urange [ * : * ] noreverse nowriteback
set vrange [ * : * ] noreverse nowriteback
set xlabel "" 
set xlabel  font "" textcolor lt -1 norotate
set x2label "" 
set x2label  font "" textcolor lt -1 norotate
#set xrange [ * : * ] noreverse writeback
set xrange [ 0 : 600 ] noreverse writeback
set x2range [ 0 : 600 ] noreverse writeback
set ylabel "" 
set ylabel  font "" textcolor lt -1 rotate
set y2label "" 
set y2label  font "" textcolor lt -1 rotate
set yrange [ * : * ] noreverse writeback
#set yrange [ 700 : 1100 ] noreverse writeback
#set yrange [ 0 : 1000 ] noreverse writeback
set y2range [ * : * ] noreverse writeback
set zlabel "" 
set zlabel  font "" textcolor lt -1 norotate
set zrange [ 15 : * ] noreverse writeback
#set zrange [ 30 : * ] noreverse writeback
#set zrange [ 0 : 100 ] noreverse writeback
set cblabel "" 
#set cblabel  font "" textcolor lt -1 rotate
set cbrange [ 15 : 110 ] noreverse writeback
#set cbrange [ * : * ] noreverse writeback
set rlabel "" 
set rlabel  font "" textcolor lt -1 norotate
set rrange [ * : * ] noreverse writeback
unset logscale
unset jitter
set zero 1e-08
set lmargin  -1
set bmargin  -1
set rmargin  -1
set tmargin  -1
set locale "en_US.UTF-8"
set pm3d implicit at b
set pm3d scansautomatic
set pm3d interpolate 1,1 flush begin noftriangles noborder corners2color mean
set pm3d nolighting
set palette positive nops_allcF maxcolors 0 gamma 1.5 color model RGB 
#set palette rgbformulae 7, 5, 15
#set palette gray
#set palette polar
#set palette rgbformulae 33,13,10
set palette defined ( 0 '#000090',1 '#000fff',2 '#0090ff',3 '#0fffee',4 '#90ff70',5 '#ffee00',6 '#ff7000',7 '#ee0000',8 '#7f0000')
set colorbox default
set colorbox vertical origin screen 0.9, 0.2 size screen 0.05, 0.6 front  noinvert bdefault
set style boxplot candles range  1.50 outliers pt 7 separation 1 labels auto unsorted
set loadpath 
set fontpath 
set psdir
set fit brief errorvariables nocovariancevariables errorscaling prescale nowrap v5
GNUTERM = "qt"

## Last datafile plotted: "ttt.dat"
set out "/home/kunitofukuda/WorkSpace/Meteor/data/outputfile.png"
#set terminal pngcairo  size 629, 400 background rgb 'black' font "Helvetica,8"
set terminal png  size 629, 400 background rgb 'black' font "Helvetica,8"
#set terminal qt 0 font "Helvetica,8"
set label 1 at screen  0.05,0.98 "KROFFT" tc rgb "green"
set label 2 at screen  0.05,0.95 "outputfile.png" tc rgb "yellow"
set label 3 at screen  0.05,0.92 "writetime" tc rgb "yellow"
set label 4 at screen  0.23,0.98 "Observer : K. FUKUDA" tc rgb "yellow"
set label 5 at screen  0.23,0.95 "receving Location : Kiryu-City, Gunma, Japan (139.2E 36.2N)" tc rgb "yellow"
set label 6 at screen  0.23,0.92 "Recever : RTL-SDR Blog V3 R820T2 RTL2832U 1PPM (89.4MHz - 900Hz) USB" tc rgb "yellow"
set label 7 at screen  0.23,0.89 "Receving antenna : Loop Antena" tc rgb "yellow"
set label 8 at screen  0.001,0.83 "kHz" tc rgb "yellow"

set label 9 at screen  0.095,0.82 "t1" tc rgb "yellow"
set label 10 at screen 0.191,0.82 "t2" tc rgb "yellow"
set label 11 at screen 0.287,0.82 "t3" tc rgb "yellow"
set label 12 at screen 0.383,0.82 "t4" tc rgb "yellow"
set label 13 at screen 0.479,0.82 "t5" tc rgb "yellow"
set label 14 at screen 0.576,0.82 "t6" tc rgb "yellow"
set label 15 at screen 0.672,0.82 "t7" tc rgb "yellow"
set label 16 at screen 0.768,0.82 "t8" tc rgb "yellow"
set label 17 at screen 0.864,0.82 "t9" tc rgb "yellow"
set label 18 at screen 0.96,0.82 "t10" tc rgb "yellow"

set multiplot layout 2,1

set lmargin screen 0.03
set rmargin screen 0.9864
set tmargin screen 0.80
set bmargin screen 0.048
set tics out
unset border
#set x2tics border in scale 1,0.5 nomirror norotate  autojustify
#set xrange [0:600]
#set x2range [0:600]
set link x2
set format x ""
#set ylabel 'Freq. [kHz]' tc rgb 'white'
set format y "%1.1f"
set ytics 0.1 textcolor rgb "yellow"
#set ytics offset 2.5, screen 0.00
set ytics offset 1.9, 0
set ticscale 0.3
set mytics 5
set border 0 lc rgb 'yellow'
#unset colorbox
#set format x2 "% h" 
#unset xtics
set x2tics axis ("" 0)
#set xtics 0,60
#set link x via x inverse x
#set xtics axis ("" 0, "23:31" 60, "23:32" 120, "23:33" 180, "23:34" 240, "23:35" 300, "23:36" 360, "23:37" 420, "23:38" 480, "23:39" 540, "" 600)
#set x2tics axis ("" 0, "100" 60)
splot "/tmp/spectrogram.dat" usi ($1):($2*1e-3):3 with pm3d ti ""

set lmargin screen 0.03
set rmargin screen 0.9864
set tmargin screen 0.072
set bmargin screen 0.00
unset border 
#unset colorbox
set tics in
set yrange [0:900]
#set ytics 300
unset ytics
#set ylabel 'intensity [arb]' tc rgb 'white'
#set ylabel 'intensity [arb]'
set ylabel ''
#set format x ""
#set format x2 ""
unset xtics
unset x2tics
#set xtics ("23:30" 0, "23:31" 60, "23:32" 120, "23:33" 180, "23:34" 240, "23:35" 300, "23:36" 360, "23:37" 420, "23:38" 480, "23:39" 540, "23:40" 600)
plot \
300 w l lc rgb "white" ti "",600 w l lc rgb "white" ti "",900 w l lc rgb "white" ti "",\
"/tmp/Meteor_intensity.dat" usi ($1+0):($2/3) with boxes ti "" lc rgb "#55ff55"

unset multiplot

#    EOF

#pause -1
