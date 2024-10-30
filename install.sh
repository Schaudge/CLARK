#! /bin/sh

#
# CLARK, CLAssifier based on Reduced K-mers.
#

#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Copyright @ The Regents of the University of California. All rights reserved.
#
#
#
#  @author: Rachid Ounit, Ph.D.
#  @project: CLARK, Metagenomic and Genomic Sequences Classification project.
#  @note: C++/Shell IMPLEMENTATION supported on latest Linux and Mac OS.
# 
# 

## Checking if OPENMP libraries are installed

FSCRPT=$(readlink -f "$0")
LDIR=$(dirname "$FSCRPT")

echo |cpp -fopenmp -dM |grep -i open > $LDIR/.tmp
NB=`wc -l < $LDIR/.tmp`

if [ ! -d $LDIR/bin/ ]; then
	mkdir $LDIR/bin/
fi

g++ -o $LDIR/bin/getTargetsDef $LDIR/src/getTargetsDef.cc $LDIR/src/file.cc -O3
g++ -o $LDIR/bin/getAccssnTaxID $LDIR/src/getAccssnTaxID.cc $LDIR/src/file.cc -O3
g++ -o $LDIR/bin/getfilesToTaxNodes $LDIR/src/getfilesToTaxNodes.cc $LDIR/src/file.cc -O3
g++ -o $LDIR/bin/getAbundance $LDIR/src/getAbundance.cc $LDIR/src/file.cc -O3
g++ -o $LDIR/bin/getConfidenceDensity $LDIR/src/getConfidencedensity.cc $LDIR/src/file.cc -O3
g++ -o $LDIR/bin/getGammaDensity $LDIR/src/getGammadensity.cc $LDIR/src/file.cc -O3
g++ -o $LDIR/bin/makeSummaryTables $LDIR/src/file.cc $LDIR/src/makeSamplesSummaryTables.cc -O3
g++ -o $LDIR/bin/converter $LDIR/src/main_spaced.cc $LDIR/src/kmersConversion.cc -O3
g++ -o $LDIR/bin/binSeq $LDIR/src/getSeqFiles.cc $LDIR/src/file.cc -O3
g++ -o $LDIR/bin/dscriptMaker $LDIR/src/dscriptMaker.cc $LDIR/src/file.cc -O3
g++ -o $LDIR/bin/getTargetSpecificKmersStat $LDIR/src/file.cc $LDIR/src/getTargetSpecificKmersStat.cc -O3
g++ -o $LDIR/bin/extractSeqs $LDIR/src/file.cc $LDIR/src/extractSequences.cc -O3

rm -Rf $LDIR/.dCLARK/
mkdir $LDIR/.dCLARK/
cp $LDIR/src/*.hh $LDIR/.dCLARK/
cp $LDIR/src/main.cc $LDIR/src/analyser.cc  $LDIR/src/file.cc  $LDIR/src/kmersConversion.cc $LDIR/.dCLARK/
cp $LDIR/src/FileHandler*.cc $LDIR/.dCLARK/

if [ $NB -eq 1 ]; then
	# OPENMP is likely supported
	# Building CLARK
       	g++ -fopenmp -o $LDIR/.dCLARK/CLARK -O3 $LDIR/.dCLARK/*.cc
       	cp $LDIR/src/parameters_hh $LDIR/.dCLARK/parameters.hh
	# Building CLARK-l (light version)       
	g++ -fopenmp -o $LDIR/.dCLARK/CLARK-l -O3 $LDIR/.dCLARK/*.cc
	cp $LDIR/src/parameters_shh $LDIR/.dCLARK/parameters.hh
        # Building CLARK-S (Spaced version)       
        g++ -fopenmp -o $LDIR/.dCLARK/CLARK-S -O3 $LDIR/.dCLARK/*.cc
else
	# Building CLARK
        g++ -o $LDIR/.dCLARK/CLARK -O3 $LDIR/.dCLARK/*.cc 
        cp $LDIR/src/parameters_hh $LDIR/.dCLARK/parameters.hh
        # Building CLARK-l (light version)
	g++ -o $LDIR/.dCLARK/CLARK-l -O3 $LDIR/.dCLARK/*.cc 
	cp $LDIR/src/parameters_shh $LDIR/.dCLARK/parameters.hh
        # Building CLARK-S (Spaced version)       
        g++ -o $LDIR/.dCLARK/CLARK-S -O3 $LDIR/.dCLARK/*.cc
fi
mv $LDIR/.dCLARK/CLARK $LDIR/bin/
mv $LDIR/.dCLARK/CLARK-l $LDIR/bin/
mv $LDIR/.dCLARK/CLARK-S $LDIR/bin/

rm -Rf $LDIR/.dCLARK $LDIR/.tmp
