import numpy as np
import matplotlib.pyplot as plt
from operator import itemgetter

def fixy(x,y,coeff, n):
    yfixed = y-(coeff[0]*x + coeff[1])
    return yfixed

num_atoms=int(raw_input('enter total number of atoms: \n'))

datafile=raw_input('enter data file name: \n')
x, y = np.genfromtxt(datafile, unpack=True)

#order of fit
n=int(raw_input('enter degrees of freedom for fit: \n'))
case=int(raw_input('0 Cutoff, 1 Formation Energy: \n'))

y /= num_atoms

#Calculate best fit order n 
#p[0] = ax^2 ,p[1] = bx, p[2] = c
p = np.polyfit(x,y,n)
line=np.polyfit(x,y,1)

#don't worry about this line
line[1]=p[2]

#rewrite fit as a function
fit =np.poly1d(p)
#generate smooth points to plot the fit
xp=np.linspace(min(x),max(x), 100)

#PLOT ENERGY DATA
plt.plot(x, y, 'ro', xp, fit(xp), 'r-')

########## Then change title and axis respectively #################

#CASE 0 FOR CUT OFF ENERGIES
if(case==0):
    plt.ylabel('Energy, eV')
    plt.xlabel('Cutoff energy, eV')
    plt.title('Energy')
    #save graph 
    d_name = datafile + '.png'
    plt.savefig(d_name, format='png')

#CASE 1 FOR FORMATION ENERGY!!!!!!!
elif (case==1):
    plt.ylabel('Energy, eV')
    plt.xlabel('Percentage composition of Mg/(Mg+Ca)')
    plt.title('Energy against Composition of Mg/(Mg+Ca)')
    #save graph 
    d_name = datafile + '.png'
    plt.savefig(d_name, format='png')
    plt.clf()

    #plot fixed energy of formation
    form_en=fixy(x, fit(x), line, int(n))

    # print lowest formation energy
    print 'lowest formation energy', min(form_en)

    # print corresponding total energy
    print 'lowest total energy', min(y*num_atoms)
    
    # print percentage for minimum formation energy
    print 'lowest formation energy percentage', x[min(enumerate(form_en), key=itemgetter(1))[0]]

    plt.plot(x, form_en, 'ro-')

    plt.ylabel('Energy, eV')
    plt.xlabel('Percentage composition of Mg/(Mg+Ca)')
    plt.title('Formation Energy for Composition of Mg/(Mg+Ca)')
    #save graph
    plt.savefig('eform.png',format='png')
