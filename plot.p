set terminal png enhanced
set xlabel "x"
set ylabel "y" 
set zlabel "z"
set nokey
set xtics 0.1
set mxtics 2
set mytics 2
unset format
#set format x "%2.0t{/Symbol \327}10^{%L}"
set term png
set output "atomarrangement.png"
splot 'O.dat', 'Mg.dat'