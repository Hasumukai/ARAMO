import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator,MultipleLocator,AutoMinorLocator
from mpl_toolkits.axes_grid1 import make_axes_locatable

x, y, z = np.loadtxt("/tmp/spectrogram.dat", unpack=True)

x_bins, y_values = np.loadtxt("/tmp/Meteor_intensity.dat", unpack=True)

#shape1=5	#1/0.2 [s]
#shape1=3000	#600/0.2 [s]
#OFFSET_TIME=0
shape2=400	#Hz

X = x.reshape(-1, shape2)+OFFSET_TIME	#time	[s]
Y = y.reshape(-1, shape2)		#Freq. [kHz]
Z = z.reshape(-1, shape2)		#Intensity [a.u.]

X = np.hstack((X, X[:, 0][:, np.newaxis]))
tmpX =  np.ones(len(X[0])) * (X.max()+1.)
X = np.vstack((X, tmpX))
#X=OFFSET_TIME
#print(X)

Y = np.vstack((Y, Y[0]))
tmpY =  np.ones(len(Y[:, 0])) * (Y.max()+1.)
Y = np.hstack((Y, tmpY[:, np.newaxis]))
Y=Y/1e3
#print(Y)

#画像全体のサイズ
fig = plt.figure(dpi=96,figsize=(6.553,4.17),facecolor="black")	#629x400pixcel
plt.rcParams["font.size"] = 8

#テキスト
fig.text(0, 0.85, 'kHz', ha='left', va='top',color="yellow")

fig.text(0.05, 0.99, 'KROFFT', ha='left', va='top',color="green")
fig.text(0.05, 0.96, 'outputfile.png', ha='left', va='top',color="yellow")
fig.text(0.05, 0.93, 'writetime', ha='left', va='top',color="yellow")

fig.text(0.24, 0.99, 'Observer : Name', ha='left', va='top',color="yellow")
fig.text(0.24, 0.96, 'Receving Location :  Kiryu, Gunma, Japan', ha='left', va='top',color="yellow")
fig.text(0.24, 0.93, 'Recever : RTL2832U (freq_base MHz cal_sym freq_diff Hz) USB', ha='left', va='top',color="yellow")
fig.text(0.24, 0.9, 'Receving antenna : Loop anttena', ha='left', va='top',color="yellow")

#2Dのマップ
#2Dのパラメータ
#ZMIN=40
#VMIN=30
#VMAX=70
ZMIN=10
VMIN=10
VMAX=100
#add_axes([x軸の開始位置, y軸の開始位置, x軸の長さ(全体に対する比率), y軸の長さ(全体に対する比率)])
ax = fig.add_axes([0.03,0.05,0.954,0.748])
Z = np.ma.masked_array(Z, Z <= ZMIN)
#intensity_map = ax.pcolormesh(X-0.1, Y-0.1, Z, vmin=VMIN,vmax=VMAX,cmap='jet')
intensity_map = ax.pcolormesh(X-0.1, Y, Z, vmin=VMIN,vmax=VMAX,cmap='jet')
ax.patch.set_alpha(0)  # subplotの背景透明度
# [Y軸(補助)] 0.02刻みで補助目盛りを設定する
ax.yaxis.set_minor_locator(MultipleLocator(0.02))
ax.tick_params(which='both',direction='out',colors="yellow")
ax.tick_params(which='major', length=3)
ax.xaxis.tick_top()
ax.set_xlabel("")
ax.set_ylabel("")
# yticklabels 位置の調整
ax.get_yaxis().set_tick_params(pad=-2)
ax.set_xlim([0,600])
#plt.xticks(np.arange(0,610,60),["","02:41","02:42","02:43","02:44","02:45","02:46","02:47","02:48","02:49",""])
plt.xticks(np.arange(0,610,60),["","t1","t2","t3","t4","t5","t6","t7","t8","t9",""])
plt.yticks(np.arange(0.7,1.1,0.1))
plt.gca().spines['right'].set_visible(False)
plt.gca().spines['top'].set_visible(False)
plt.gca().spines['bottom'].set_visible(False)
plt.gca().spines['left'].set_visible(False)

#カラーバー
#divider = make_axes_locatable(ax)
#colorbar_ax = divider.append_axes("right", "5%", pad="3%")
#fig.add_axes(colorbar_ax)
#fig.colorbar(intensity_map, cax=colorbar_ax)


#強度のヒストグラム
ax_hist = fig.add_axes([0.03,0,0.95,0.075])
ax_hist.bar(x_bins, y_values, width=1, ecolor='green')
ax_hist.set_xlim([0,600])
ax_hist.patch.set_alpha(0)  # subplotの背景透明度
ax_hist.grid(axis="y", color="white")
ax_hist.tick_params(which='both',direction='out',colors="yellow")
plt.yticks(np.arange(0,1e3,300))
plt.yticks(color="None")
plt.gca().spines['right'].set_visible(False)
plt.gca().spines['top'].set_visible(False)
plt.gca().spines['bottom'].set_visible(False)
plt.gca().spines['left'].set_visible(False)

# 上下のグラフの隙間をなくす
plt.subplots_adjust(hspace=.0)

plt.savefig("main_path/data/folder/outputfile.png")   # プロットしたグラフをPNG形式で保存する
#plt.show()
