import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator,MultipleLocator,AutoMinorLocator
from mpl_toolkits.axes_grid1 import make_axes_locatable
import sys
#課題
#集計する周波数を可視化する。

start_freq=int(sys.argv[1])
end_freq=int(sys.argv[2])

VMIN=20
VMAX=60
ZMIN=VMIN+1

#x, y, z = np.loadtxt("/tmp/spectrogram.dat", unpack=True)
z = np.loadtxt("/tmp/spectrogram.dat", unpack=True)
#z=z/3
print(z.shape)

#x_bins, y_values = np.loadtxt("/tmp/Meteor_intensity.dat", unpack=True)
#y_values = np.loadtxt("/tmp/Meteor_intensity.dat", unpack=True)
#y_values = 50*y_values

#shape1=5	#1/0.2 [s]
#shape1=3000	#600/0.2 [s]
#OFFSET_TIME=0
#shape2=601	#Hz

#X = x.reshape(-1, shape2)+OFFSET_TIME	#time	[s]
#Y = y.reshape(-1, shape2)		#Freq. [kHz]
#Z = z.reshape(-1, shape2)		#Intensity [a.u.]

#X = np.hstack((X, X[:, 0][:, np.newaxis]))
#tmpX =  np.ones(len(X[0])) * (X.max()+1.)
#X = np.vstack((X, tmpX))
#X=OFFSET_TIME
#print(X)

#Y = np.vstack((Y, Y[0]))
#tmpY =  np.ones(len(Y[:, 0])) * (Y.max()+1.)
#Y = np.hstack((Y, tmpY[:, np.newaxis]))
#Y=Y/1e3
#print(Y)

#画像全体のサイズ
#rect=[0.03,0.05,0.954,0.748]
#grd_kw = dict(left=0.03, right=0.957, bottom=0.05, top=0.753)
fig = plt.figure(dpi=96,figsize=(6.553,4.17),facecolor="black")	#629x400pixcel
#fig, axes = plt.subplots(2,1,dpi=96,figsize=(6.553,4.17),gridspec_kw=grd_kw,facecolor="black")	#629x400pixcel
#fig = plt.figure(dpi=96)	#629x400pixcel
plt.rcParams["font.size"] = 8

#テキスト
fig.text(0, 0.85, 'kHz', ha='left', va='top',color="yellow")

#fig.text(0.05, 0.99, 'KROFFT', ha='left', va='top',color="green")
fig.text(0.05, 0.99, 'ARAMO', ha='left', va='top',color="lawngreen")
fig.text(0.05, 0.96, 'outputfile.png', ha='left', va='top',color="yellow")
fig.text(0.05, 0.93, 'writetime', ha='left', va='top',color="yellow")

fig.text(0.24, 0.99, 'Meteor', ha='left', va='top',color="yellow")

f=open('main_path/obs_setting.txt','r')
text_height=0.99
for data in f:
#	fig.text(0.24, text_height, data, ha='left', va='top',color="yellow")
	fig.text(0.34, text_height, data, ha='left', va='top',color="yellow")
	text_height-=0.03
f.close()
	
#fig.text(0.24, 0.99, 'Observer : Hasumukai', ha='left', va='top',color="yellow")
#fig.text(0.24, 0.96, 'Receving Location :  Kiryu, Gunma, Japan', ha='left', va='top',color="yellow")
#fig.text(0.24, 0.93, 'Recever : NESDR SMArt v5 (114.1 MHz - 60 Hz) USB', ha='left', va='top',color="yellow")
#fig.text(0.24, 0.9, 'Receving antenna : Loop anttena', ha='left', va='top',color="yellow")

#2Dのマップ
#2Dのパラメータ
#ZMIN=50
#VMIN=30
#VMAX=300
#ZMIN=0
#VMIN=0
#VMAX=60
#ax=axes[0]
#add_axes([x軸の開始位置, y軸の開始位置, x軸の長さ(全体に対する比率), y軸の長さ(全体に対する比率)])
ax = fig.add_axes([0.03,0.05,0.954,0.748])
#ax = fig.subplots(211)
#ax = fig.add_axes([0.03,0.05,0.954,0.748])
#rect=[0.03,0.05,0.954,0.748]
#rect=[0.03,0.05,0.5,0.748]
#cax = fig.add_axes(rect)
#ax = fig.add_axes([0.0,0.0,1,1])
#ax = fig.add_axes([0.0,0.0,1.0,0.748])
Z = np.ma.masked_array(z, z <= ZMIN)
#Z = z
#print(Z)
#cm_name='jet'
#cm=plt.get_cmap(cm_name)
#x=np.linspace(0,600,600)
#y=np.linspace(500,1600,600)
#ax[1].scatter(x,y,c=Z,cmap=cm)
#ax.imshow(Z,cmap=cm)
#plt.colorbar(im)
#plt.show()

###intensity_map = ax.pcolormesh(X-0.1, Y-0.1, Z, vmin=VMIN,vmax=VMAX,cmap='jet')
##intensity_map = ax.pcolormesh(X-0.1, Y, Z, vmin=VMIN,vmax=VMAX,cmap='jet')
intensity_map = ax.pcolormesh(Z,vmin=VMIN,vmax=VMAX,cmap='jet')
#ax.imshow(Z,cmap=cm)
ax.patch.set_alpha(0)  # subplotの背景透明度
ax.tick_params(which='both',direction='out',colors="yellow")
ax.tick_params(which='major', length=3)
ax.xaxis.tick_top()
ax.set_xlabel("")
ax.set_ylabel("")
## yticklabels 位置の調整
ax.get_yaxis().set_tick_params(pad=-2)
ax.set_xlim([0,600])
plt.xticks(np.arange(0,610,60),["","t1","t2","t3","t4","t5","t6","t7","t8","t9",""])


measure_freq_low=850
measure_freq_high=950
#ax.vlines(1, measure_freq_low-start_freq, measure_freq_high-start_freq, color='g', linestyles='dotted')
ax.vlines(1, measure_freq_low-start_freq, measure_freq_high-start_freq, color='g')
y_tic=np.arange(start_freq,end_freq+10,100)/1000
plt.yticks(np.arange(0,end_freq-start_freq+10,100),y_tic)
## [Y軸(補助)] 20刻みで補助目盛りを設定する
ax.yaxis.set_minor_locator(MultipleLocator(20))
ax.yaxis.set_ticks_position('both')

#plt.yticks(np.arange(0,610,100),["0.6","0.7","0.8","0.9","1.0","1.1","1.2"])
#plt.yticks(np.arange(0,1210,100),["0.5","0.6","0.7","0.8","0.9","1.0","1.1","1.2","1.3","1.4","1.5","1.6","1.7"])
#plt.gca().spines['right'].set_visible(False)
#plt.gca().spines['top'].set_visible(False)
#plt.gca().spines['bottom'].set_visible(False)
#plt.gca().spines['left'].set_visible(False)
#
##カラーバー
##divider = make_axes_locatable(ax)
##colorbar_ax = divider.append_axes("right", "5%", pad="3%")
##fig.add_axes(colorbar_ax)
##fig.colorbar(intensity_map, cax=colorbar_ax)



###強度のヒストグラム
#make data
#measure_lower=850
#measure_upper=950
#L=600
#print(L)
#print(range(0,600))
def intg(measure_lower,measure_upper,start_freq):
	yv=[]
	L=z.shape[1]
	In=150
	for i in range(0,L):
	#	yvn=In*sum(z[850-start_freq:950-start_freq,i])/(measure_upper-measure_lower)
		zn=z[measure_lower-start_freq:measure_upper-start_freq,i]
		yvn=In*sum(zn[zn>ZMIN])/(measure_upper-measure_lower)
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
#ax_hist=axes[1]
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
#plt.gca().spines['right'].set_visible(False)
#plt.gca().spines['top'].set_visible(False)
#plt.gca().spines['bottom'].set_visible(False)
#plt.gca().spines['left'].set_visible(False)

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

f=open("main_path/data/folder/outputfile.txt",'w')
f.write(str(MeteorN))
f.close()

# 上下のグラフの隙間をなくす
plt.subplots_adjust(hspace=.0)

plt.savefig("main_path/data/folder/outputfile.png")   # プロットしたグラフをPNG形式で保存する
#plt.savefig("outputfile.png")   # プロットしたグラフをPNG形式で保存する
#plt.show()
