import numpy as np
#import matplotlib
import matplotlib.pyplot as plt
#matplotlib.use('Agg')
#from matplotlib.ticker import MaxNLocator,MultipleLocator,AutoMinorLocator
#from mpl_toolkits.axes_grid1 import make_axes_locatable

#x, y, z = np.loadtxt("/tmp/spectrogram.dat", unpack=True)
z = np.loadtxt("spectrogram1.dat", unpack=True)
print(z.shape)

fig,ax=plt.subplots()
im=ax.imshow(z)
plt.show()

#UserWarning: FigureCanvasAgg is non-interactive, and thus cannot be shown
