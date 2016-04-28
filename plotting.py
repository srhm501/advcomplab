import numpy as np
import matplotlib.pyplot as plt

datafile=raw_input()
x, y = np.genfromtxt(datafile, unpack=True)

#order of fit
n=2

#Calculate best fit order n 
p = np.polyfit(x,y,n)
print p

fit= np.polyval(p, x)

plt.plot(x, y, 'ro', x, np.polyval(p, x), 'r-')

plt.ylabel('Energy, eV')
plt.xlabel('Percentage composition of Mg/Ca')

#save graph 
d_name = datafile + '.png'
plt.savefig(d_name, format='png')
plt.close()
