import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator,MultipleLocator,AutoMinorLocator
from mpl_toolkits.axes_grid1 import make_axes_locatable
import sys

start_freq=int(sys.argv[1])
end_freq=int(sys.argv[2])

VMIN=20
VMAX=80
ZMIN=VMIN+1

z = np.loadtxt("/tmp/spectrogram.dat", unpack=True)
print(z.shape)

Z = np.ma.masked_array(z, z <= ZMIN)
#Z = z

def intg(measure_lower,measure_upper,start_freq):
	yv=[]
	L=z.shape[1]
	In=150
	for i in range(0,L):
		zn=z[measure_lower-start_freq:measure_upper-start_freq,i]
		yvn=In*sum(zn[zn>ZMIN])/(measure_upper-measure_lower)
		yv.append(yvn)
	return yv

#yv=intg(1080,1180,start_freq)	#high freq
#yh_values=np.array(yv)
#
#yv=intg(610,710,start_freq)	#low freq
#yl_values=np.array(yv)

#y_vli = y_values<=THRESHOLD
#print(y_vli)
#y_vl=y_values[y_vli]
def CountM(y_values):
	THRESHOLD=300
	y_vhi = y_values>THRESHOLD
	
	#Meteor count
	MeteorN=0
	t_old=0
	Meteor_time=[]
	time=0
	for t in y_vhi:
#		yh=yh_values[time]
#		yl=yl_values[time]
		#Now over and last under
		if t==True and t_old==False:
	#		if yh<=THRESHOLD and yl<=THRESHOLD:
			MeteorN+=1
#			Meteor_time.append(time)
		t_old=t
		time+=1
	return MeteorN

width=100
lengthN=int((end_freq-start_freq)/width)
data=[[0]*2 for i in range(lengthN)]
i=0
for CenterFreq in range(start_freq,end_freq,width):
	CenterFreq=int(CenterFreq+width/2)
#	CenterFreq=900
	FreqLow=int(CenterFreq-width/2)
	FreqHigh=int(CenterFreq+width/2)
	yv=intg(FreqLow,FreqHigh,start_freq)
	y_values=np.array(yv)
	
	MeteorN=CountM(y_values)
	data[i][0]=CenterFreq
	data[i][1]=MeteorN
	i+=1
#	print(CenterFreq,MeteorN)

#print(data)
np.savetxt('main_path/data/folder/outputfile_search.dat',data,fmt='%d')
#np.savetxt('search.dat',data,fmt='%d')
#f=open("main_path/data/folder/outputfile_search.dat",'w')
#print(Meteor_time)

#y_posi=1.
#count=1
#for time in Meteor_time:
#	x_posi=time
#	count+=1

#Freq1 : MeteorN1
#Freq2 : MeteorN2
#f=open("main_path/data/folder/outputfile_search.dat",'w')
#f.write(str(MeteorN))
#f.close()
