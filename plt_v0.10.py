import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator,MultipleLocator,AutoMinorLocator
from mpl_toolkits.axes_grid1 import make_axes_locatable
import sys
#課題
#集計する周波数を可視化する。

class DrawFig:
	def __init__(self,sf,ef):
		start_freq=sf
		end_freq=ef
		
		self.VMIN=25
		self.VMAX=70
		self.ZMIN=self.VMIN+1
#		self.DataName="spectrogram2.dat"

	#load data
	def load_data(self,DataName):
		self.z = np.loadtxt(DataName, unpack=True)
		print(self.z.shape)
#		return z
#	z=load_data(DataName)

#		plt_sf=0	#300
#		plt_ef=600	#900
	def make_graphi(self,SetName,SaveMeteorNumberName,SaveFigName,plt_sf,plt_ef):
		#set fig size
		fig = plt.figure(dpi=96,figsize=(6.553,4.17),facecolor="black")	#629x400pixcel
		plt.rcParams["font.size"] = 8
		
		#set text
		fig.text(0, 0.85, 'kHz', ha='left', va='top',color="yellow")
		
		fig.text(0.05, 0.99, 'ARAMO', ha='left', va='top',color="lawngreen")
		fig.text(0.05, 0.96, 'outputfile.png', ha='left', va='top',color="yellow")
		fig.text(0.05, 0.93, 'writetime', ha='left', va='top',color="yellow")
		
		fig.text(0.24, 0.99, 'Meteor', ha='left', va='top',color="yellow")
		
		#load setting text
#		f=open('/home/kunitofukuda/workspace/meteor/ARAMO/obs_setting.txt','r')
		f=open(SetName,'r')
		text_height=0.99
		for data in f:
			fig.text(0.34, text_height, data, ha='left', va='top',color="yellow")
			text_height-=0.03
		f.close()
			
		#make 2D map
		ax = fig.add_axes([0.03,0.05,0.954,0.748])
		Z = np.ma.masked_array(self.z, self.z <= self.ZMIN)
		
		intensity_map = ax.pcolormesh(Z,vmin=self.VMIN,vmax=self.VMAX,cmap='jet')
		ax.patch.set_alpha(0)  # subplotの背景透明度
		ax.tick_params(which='both',direction='out',colors="yellow")
		ax.tick_params(which='major', length=3)
		ax.xaxis.tick_top()
		ax.set_xlabel("")
		ax.set_ylabel("")
		ax.get_yaxis().set_tick_params(pad=-2)
		ax.set_xlim([0,300])
#		plt.xticks(np.arange(0,610,60),["","23:51","23:52","23:53","23:54","23:55","23:56","23:57","23:58","23:59",""])
		plt.xticks(np.arange(0,610,60),["","t1","t2","t3","t4","t5","t6","t7","t8","t9",""])
		
		
#		plt_sf=0	#300
#		plt_ef=600	#900
		measure_freq_low=plt_sf+start_freq+250
		measure_freq_high=plt_sf+start_freq+350
#		measure_freq_low=550
#		measure_freq_high=650
		ax.vlines(1, measure_freq_low-start_freq, measure_freq_high-start_freq, color='g')
		y_tic=np.arange(start_freq,end_freq+10,100)/1000
		plt.yticks(np.arange(0,end_freq-start_freq+10,100),y_tic)
		## [Y軸(補助)] 20刻みで補助目盛りを設定する
		ax.yaxis.set_minor_locator(MultipleLocator(20))
		ax.yaxis.set_ticks_position('both')
		ax.set_ylim([plt_sf,plt_ef])
		
		
		#intensity histgram
		def intg(measure_lower,measure_upper,start_freq):
			yv=[]
			L=self.z.shape[1]
			In=150
			for i in range(0,L):
			#	yvn=In*sum(z[850-start_freq:950-start_freq,i])/(measure_upper-measure_lower)
				zn=self.z[measure_lower-start_freq:measure_upper-start_freq,i]
				yvn=In*sum(zn[zn>self.ZMIN])/(measure_upper-measure_lower)
				yv.append(yvn)
			return yv
			#print(yv)
		yv=intg(measure_freq_low,measure_freq_high,start_freq)
		y_values=np.array(yv)
		
		yv=intg(1080,1180,start_freq)	#high freq
		yh_values=np.array(yv)
		
		yv=intg(610,710,start_freq)	#low freq
		yl_values=np.array(yv)
		
		ax_hist = fig.add_axes([0.03,0,0.954,0.075])
		#change color if values will over threshold
		#閾値以上の値は色を変える
		THRESHOLD=300
		y_vli = y_values<=THRESHOLD
		#print(y_vli)
		y_vl=y_values[y_vli]
		y_vhi = y_values>THRESHOLD
		y_vh=y_values[y_vhi]
		yN=y_values.shape[0]
		
		x_bins=np.linspace(0,yN,yN)
		ax_hist.bar(x_bins[y_vli], y_vl, width=1, color='gray')
		ax_hist.bar(x_bins[y_vhi], y_vh, width=1, color='yellowgreen')
		ax_hist.set_xlim([0,600])
		ax_hist.set_ylim([0,910])
		ax_hist.patch.set_alpha(0)  # subplotの背景透明度
		ax_hist.grid(axis="y", color="white")
		plt.yticks(np.arange(0,1210,300))
		plt.yticks(color="None")
		
		#Meteor count
		MeteorN=0
		t_old=0
		Meteor_time=[]
		time=0
		for t in y_vhi:
			yh=yh_values[time]
			yl=yl_values[time]
			#Now over and last under
			if t==True and t_old==False:
				if yh<=THRESHOLD and yl<=THRESHOLD:
					MeteorN+=1
					Meteor_time.append(time)
			t_old=t
			time+=1
		print(MeteorN)
		print(Meteor_time)
		fig.text(0.24, 0.93, str(MeteorN), ha='left', va='top',color="yellow")
		
		#Maker
		ax_mark = fig.add_axes([0.03,0.75,0.954,0.1])
		ax_mark.set_xlim([0,600])
		ax_mark.patch.set_alpha(0)  # subplotの背景透明度
		y_posi=1.
		count=1
		for time in Meteor_time:
			x_posi=time
			ax_mark.plot(x_posi,y_posi,marker='v',markersize=5,color="lawngreen")
		#	fig.text(x_posi/600-0.01, 0.84, count, ha='left', va='top',color="yellow")
			fig.text(0.025+0.951*x_posi/600, 0.84, count, ha='left', va='top',color="lawngreen")
			count+=1
		
#		f=open("/home/kunitofukuda/workspace/meteor/ARAMO/data/20240705/202407052350.txt",'w')
		f=open(SaveMeteorNumberName,'w')
		f.write(str(MeteorN))
		f.close()
		
		# 上下のグラフの隙間をなくす
		plt.subplots_adjust(hspace=.0)
		
		#save
#		plt.savefig("/home/kunitofukuda/workspace/meteor/ARAMO/data/20240705/202407052350.png")   # プロットしたグラフをPNG形式で保存する
		plt.savefig(SaveFigName)

start_freq=int(sys.argv[1])
end_freq=int(sys.argv[2])

DataName='/tmp/spectrogram.dat'
SetName='main_path/obs_setting.txt'
SaveMeteorNumberName="main_path/data/folder/outputfile.txt"

aramo_base=DrawFig(start_freq,end_freq)
aramo_base.load_data(DataName)

FreqWidth=600
for plt_sf in range(0,end_freq-start_freq,FreqWidth):
	if plt_sf+FreqWidth > end_freq:
		plt_sf=end_freq-FreqWidth
	print(plt_sf)
	#plt_sf=0	#300
	plt_ef=FreqWidth+plt_sf	#900
	SaveFigName="main_path/data/folder/outputfile_"+str(plt_sf+start_freq)+".png"
	aramo_base.make_graphi(SetName,SaveMeteorNumberName,SaveFigName,plt_sf,plt_ef)


#plt_sf=0	#300
#plt_ef=FreqWidth+plt_sf	#900
#SaveFigName="/home/kunitofukuda/workspace/meteor/ARAMO/data/20240705/202407052350_"+str(plt_sf+start_freq)+".png"
#aramo_base.make_graphi(SetName,SaveMeteorNumberName,SaveFigName,plt_sf,plt_ef)
#
#plt_sf=600	#300
#plt_ef=FreqWidth+plt_sf	#900
#SaveFigName="/home/kunitofukuda/workspace/meteor/ARAMO/data/20240705/202407052350_"+str(plt_sf+start_freq)+".png"
#aramo_base.make_graphi(SetName,SaveMeteorNumberName,SaveFigName,plt_sf,plt_ef)
