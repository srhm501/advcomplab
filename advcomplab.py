#!/usr/bin/python
import visual
import os 

"""
In-source documentation
-----------------------
There are emerging conventions about the content and formatting of documentation
strings.

The first line should always be a short, concise summary of the object's purpose.
For brevity, it should not explicitly state the object's name or type, since
these are available by other means (except if the name happens to be a verb
describing a function's operation). This line should begin with a capital letter
and end with a period.

If there are more lines in the documentation string, the second line should be
blank, visually separating the summary from the rest of the description. The
following lines should be one or more paragraphs describing the object's calling
conventions, its side effects, etc.

The Python parser does not strip indentation from multi-line string literals in
Python, so tools that process documentation have to strip indentation if
desired. This is done using the following convention. The first non-blank line
after the first line of the string determines the amount of indentation for the
entire documentation string. (We cannot use the first line since it is generally
adjacent to the string's opening quotes so its indentation is not apparent in
the string literal.) Whitespace "equivalent" to this indentation is then
stripped from the start of all lines of the string. Lines that are indented less
should not occur, but if they occur all their leading whitespace should be
stripped. Equivalence of whitespace should be tested after expansion of tabs
(to 8 spaces, normally).

Coding style
------------
Now that you are about to write longer, more complex pieces of Python,
it is a good time to talk about coding style. Most languages can be
written (or more concise, formatted) in different styles; some are
more readable than others. Making it easy for others to read your code
is always a good idea, and adopting a nice coding style helps
tremendously for that.

For Python, PEP 8 has emerged as the style guide that most projects
adhere to; it promotes a very readable and eye-pleasing coding style.
Every Python developer should read it at some point; here are the most
important points extracted for you:

Use 4-space indentation, and no tabs.

4 spaces are a good compromise between small indentation (allows greater nesting depth) and large indentation (easier to read). Tabs introduce confusion, and are best left out.

Wrap lines so that they don't exceed 79 characters.

This helps users with small displays and makes it possible to have several code files side-by-side on larger displays.

Use blank lines to separate functions and classes, and larger blocks
of code inside functions.

When possible, put comments on a line of their own.

Use docstrings.

Use spaces around operators and after commas, but not directly inside
bracketing constructs: a = f(1, 2) + g(3, 4).

Name your classes and functions consistently; the convention is to use
CamelCase for classes and lower_case_with_underscores for functions
and methods. Always use self as the name for the first method argument
(see A First Look at Classes for more on classes and methods).

Do not use fancy encodings if your code is meant to be used in
international environments. Plain ASCII works best in any case.

Speed
-----
See Python documentation section 10.10, "Performance".

Testing
-------
See Python documentation section 10.11, "Quality Control".

Logging
-------
See Python documentation section 11.5, "Logging".
"""

print "Current directory:", os.getcwd()

elementName = [ "H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg", "Al", "Si", "S", "Cl", "Ar" ]

class atom:
    def __init__(self,name,v):
        self.name = name
        self.position = v
        self.pic = visual.sphere(pos=self.position,radius=1.0,color=visual.color.orange)
        
# Create the empty list myAtoms
myAtoms = []

# Create the empty list fracPos
fracPos = []

lattice = []

# Get the fractional coordinates and lattice from the CASTEP input cell file
with open("/usr/userfs/o/ot561/Documents/yr3/t3labs/test.cell", "r") as inputFile:

    inPosBlock = False
    inLatticeBlock = False

    for line in inputFile:
        if inPosBlock:
            if line.lower() == "%endblock positions_frac\n":
                inPosBlock = False
            else:
                name, x, y, z= line.split()
                print "Found atom:", name, "at", x,y,z
                fracPos.append([name,x,y,z])

        if inLatticeBlock:
            if line.lower() == "%endblock lattice_cart\n":
                inLatticeBlock = False
            else:
                x,y,z = line.split()
                lattice.append(visual.vector(float(x),float(y),float(z)))

        if line.lower() == "%block lattice_cart\n":
            inLatticeBlock = True

        if line.lower() == "%block positions_frac\n":
            inPosBlock = True

inputFile.close()

# Draw the lattice vectors
for a in lattice:
    visual.arrow(pos=visual.vector(0.0,0.0,0.0),axis=a)

for a in fracPos:
    print a
    absPos = visual.vector(0.0,0.0,0.0)
    # Convert to absolute, Cartesian co-ordinates
    for i in [ 0, 1, 2 ]:
        absPos = absPos + float(a[i+1])*lattice[i]
    #print absPos
    # Add to displayed atoms
    myAtoms.append(atom(a[0],absPos))

bonds = []
for a in myAtoms:
    for b in myAtoms:
        if abs(a.position - b.position)<5.0:
            bonds.append(visual.cylinder(pos=a.position,axis=(b.position-a.position),radius=0.1,color=visual.color.orange))

