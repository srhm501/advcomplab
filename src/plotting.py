import numpy as np
import matplotlib.pyplot as plt

def fixy(x,y,coeff, n):
    
    #cheating=True
    #cheating=False
    cheating ='wrong'
	
    if(cheating == True):
        eca=y[0]
        emg=y[len(x)-1]

    elif (cheating == False):
	eca =coeff[n]
        emg =coeff[n-1]+coeff[n]
    	yfixed=[]
    	for i in range(0,len(x)):
 	    #eca is the intercept, 0%mg, c
	    #emg is the value at 100%mg, m+c
	    #y[i] is the value of Etot
	    eform= y[i] -eca*(1.0-x[i]) - emg*(x[i])  
            yfixed.append(eform)
    else:
 	yfixed = -y+(coeff[0]*x + coeff[1])

    return yfixed

datafile=raw_input('enter data file name: ')
x, y = np.genfromtxt(datafile, unpack=True)

#order of fit
n=int(raw_input('enter degrees of freedom for fit'))
print n
#Calculate best fit order n 
#p[0] = ax^2
#p[1] = bx
#p[2] = c
p = np.polyfit(x,y,n)
line=np.polyfit(x,y,1)
line[1]=p[2]
print p
print line

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
#plt.plot(x, fixy(x,fit(x), line, int(n)), 'ro-')
#print fixy(x,fit(x), line, n)

plt.ylabel('Energy, eV')
plt.xlabel('Percentage composition of Mg/Ca')
plt.title('Formation Energy for Composition of Mg/Ca')
#save graph
plt.savefig('eform.png',format='png')