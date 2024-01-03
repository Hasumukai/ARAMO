import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator,MultipleLocator,AutoMinorLocator
from mpl_toolkits.axes_grid1 import make_axes_locatable

x, y, z = np.loadtxt("./spectrogram2.dat", unpack=True)
#x, y, z = np.loadtxt("./plt_test_data.dat", unpack=True)

x_bins, y_values = np.loadtxt("./Meteor_intensity2.dat", unpack=True)

#shape1=5	#1/0.2 [s]
shape1=3000	#600/0.2 [s]
shape2=400	#Hz

X = x.reshape(shape1, shape2)	#time	[s]
Y = y.reshape(shape1, shape2)	#Freq. [kHz]
Z = z.reshape(shape1, shape2)	#Intensity [a.u.]

X = np.hstack((X, X[:, 0][:, np.newaxis]))
tmpX =  np.ones(len(X[0])) * (X.max()+1.)
X = np.vstack((X, tmpX))
#print(X)

Y = np.vstack((Y, Y[0]))
tmpY =  np.ones(len(Y[:, 0])) * (Y.max()+1.)
Y = np.hstack((Y, tmpY[:, np.newaxis]))
Y=Y/1e3+0.1
#print(Y)

#画像全体のサイズ
#fig = plt.figure(figsize=(4,4))
fig = plt.figure(dpi=96,figsize=(6.553,4.17),facecolor="black")	#629x400pixcel
#fig = plt.figure(dpi=96,figsize=(6.553,4.17))	#629x400pixcel
plt.rcParams["font.size"] = 8

#テキスト
fig.text(0, 0.85, 'kHz', ha='left', va='top',color="yellow")

fig.text(0.05, 0.99, 'KROFFT', ha='left', va='top',color="green")
fig.text(0.05, 0.96, '202301030240.png', ha='left', va='top',color="yellow")
fig.text(0.05, 0.93, '2024/01/03 02:40', ha='left', va='top',color="yellow")

fig.text(0.24, 0.99, 'Observer : Kunito FUKUDA', ha='left', va='top',color="yellow")
fig.text(0.24, 0.96, 'Receving Location : Kiryu, Gunma, Japan', ha='left', va='top',color="yellow")
fig.text(0.24, 0.93, 'Recever : RTL2832U (89.4 MHz - 780 Hz) USB', ha='left', va='top',color="yellow")
fig.text(0.24, 0.9, 'Receving antenna : Loop anttena', ha='left', va='top',color="yellow")

#2Dのマップ
#2Dのパラメータ
ZMIN=35
VMIN=35
VMAX=60
#gs = fig.add_gridspec(2, 3)
#print(gs[0,0:2])
#ax = fig.add_subplot(211)
#add_axes([x軸の開始位置, y軸の開始位置, x軸の長さ(全体に対する比率), y軸の長さ(全体に対する比率)])
ax = fig.add_axes([0.03,0.05,0.954,0.748])
#ax = fig.add_subplot([100,100],)
Z = np.ma.masked_array(Z, Z <= ZMIN)
intensity_map = ax.pcolormesh(X-0.1, Y-0.1, Z, vmin=VMIN,vmax=VMAX,cmap='jet')
ax.patch.set_alpha(0)  # subplotの背景透明度
# [Y軸(補助)] 0.02刻みで補助目盛りを設定する
ax.yaxis.set_minor_locator(MultipleLocator(0.02))
ax.tick_params(which='both',direction='out',colors="yellow")
ax.tick_params(which='major', length=3)
#ax.tick_params(direction='out',colors="yellow")
ax.xaxis.tick_top()
#ax.set_ylim([0.7,1.1])
ax.set_xlabel("")
ax.set_ylabel("")
# yticklabels 位置の調整
ax.get_yaxis().set_tick_params(pad=-2)
ax.set_xlim([0,600])
#ax.set_aspect('equal')
#plt.minorticks_on()
plt.xticks(np.arange(0,610,60),["","02:41","02:42","02:43","02:44","02:45","02:46","02:47","02:48","02:49",""])
#plt.xticks(np.arange(60,610,60))
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
#ax_hist = fig.add_subplot(212)
#ax_hist.bar(x_bins, y_values, width=1, ec='black')
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

#plt.show()

plt.savefig("test.png")   # プロットしたグラフをPNG形式で保存する
plt.show()