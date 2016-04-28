import numpy as np
import matplotlib.pyplot as plt

def fixy(x,y,coeff):
    #subtract mx+c
    yfixed=y-(coeff[1]*x+coeff[2])
    return yfixed

datafile=raw_input('enter data file name: ')
x, y = np.genfromtxt(datafile, unpack=True)

#order of fit
n=raw_input('enter degrees of freedom for fit')

#Calculate best fit order n 
p = np.polyfit(x,y,n)
#print coefficients
#p[0]=ax^n, p[1]=bx^(n-1) etc
print p

#rewrite fit as a function
fit =np.poly1d(p)
#generate smooth points to plot the fit
xp=np.linspace(min(x),max(x), 100)

plt.plot(x, y, 'ro', xp, fit(xp), 'r-')

plt.ylabel('Energy, eV')
plt.xlabel('Percentage composition of Mg/Ca')
plt.title('Energy against Composition of Mg/Ca')
#save graph 
d_name = datafile + '.png'
plt.savefig(d_name, format='png')
plt.clf()

#plot fixed energy of formation
plt.plot(xp, fixy(xp,fit(xp), p), 'r-')
plt.ylabel('Energy, eV')
plt.xlabel('Percentage composition of Mg/Ca')
plt.title('Formation Energy for Composition of Mg/Ca')
#save graph
plt.savefig('eform.png',format='png')
