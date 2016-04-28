import numpy as np
import matplotlib.pyplot as plt

def fixy(x,y,coeff, n):
    #subtract mx+c
    #yfixed=y-(coeff[n-1]*x+coeff[n])
    #subtract ax^2 +mx + c
    yfixed=y-(coeff[n-2]*x**2+coeff[n-1]*x+coeff[n])
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

p2=np.polyfit(x,y,1)
print p2
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
plt.plot(x, fixy(x,y, p, int(n)), 'ro-')
#plt.plot(xp, p[0]*xp**2, 'r-')
plt.ylabel('Energy, eV')
plt.xlabel('Percentage composition of Mg/Ca')
plt.title('Formation Energy for Composition of Mg/Ca')
#save graph
plt.savefig('eform.png',format='png')
