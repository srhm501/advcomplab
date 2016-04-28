import numpy as np
import matplotlib.pyplot as plt

datafile=raw_input('enter data file name: ')
x, y = np.genfromtxt(datafile, unpack=True)

#order of fit
n=raw_input('enter degrees of freedom for fit')

#Calculate best fit order n 
p = np.polyfit(x,y,n)
#print coefficients
print p

#rewrite fit as a function
fit =np.poly1d(p)
#generate smooth points to plot the fit
xp=np.linspace(min(x),max(x), 100)

plt.plot(x, y, 'ro', xp, fit(xp), 'r-')

plt.ylabel('Energy, eV')
plt.xlabel('Percentage composition of Mg/Ca')

#save graph 
d_name = datafile + '.png'
plt.savefig(d_name, format='png')
plt.close()
