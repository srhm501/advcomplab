import numpy as np
import matplotlib.pyplot as plt

def fixy(x,y,coeff, n):

    cheating =False
    
    if(cheating == True):
        emg=y[0]
        eca=y[len(x)-1]
    else:
	emg =coeff[n]
        eca =coeff[n-1]+coeff[n]
    yfixed=[]
    for i in range(0,len(x)):
	#where emg is the intercept,c
	#eca is the value at 100%, m+c
	eform= y[i]-emg -eca*x[i] + emg*x[i]  
	yfixed.append(eform)
 
    return yfixed

datafile=raw_input('enter data file name: ')
x, y = np.genfromtxt(datafile, unpack=True)

#order of fit
n=raw_input('enter degrees of freedom for fit')

#Calculate best fit order n 
p = np.polyfit(x,y,n)
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
plt.plot(x, fixy(x,y, p, int(n)), 'ro-')
#plt.plot(xp, p[0]*xp**2, 'r-')
plt.ylabel('Energy, eV')
plt.xlabel('Percentage composition of Mg/Ca')
plt.title('Formation Energy for Composition of Mg/Ca')
#save graph
plt.savefig('eform.png',format='png')
