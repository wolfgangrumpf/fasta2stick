#!/bin/bash
#
# FASTA Alignment to StickWRLD Format 1.0
# June 27 2014
# by Wolfgang Rumpf
# The Research Institute at Nationwide Children's Hospital
# wolfgang.rumpf@nationwidechildrens.org
#
#
# This script converts a standard FASTA sequence alignment to the format StickWRLD uses
# NOTE:  for best results use a standard editor like SEAVIEW to create your FASTA format alignment
#
#
#
# Let's start by welcoming the user
clear
echo "FASTA Alignment to StickWRLD Format v1.0"
echo ""
echo "By Wolfgang Rumpf"
echo""
#
#

# Ask the user for the name of the input and output files
#
read -e -p "Enter the name of the input file: " INFILE
read -e -p "Enter the name of the output file: " OUTFILE

# This line takes a standard FASTA sequence and removes all line breaks so that it is a single contiguous line
#
cat $INFILE | awk '{if (substr($0,1,1)==">"){if (p){print "\n";} print $0} else printf("%s",$0);p++;}END{print "\n"}' > tmp1

# This section of code removes the blank lines between sequences
#
# First make sure that linefeeds are linux format, not Windows
#
cat tmp1 | perl -pi -e 's/\r\n/\n/g' > tmp2
#
# Now strip out the blank lines
#
cat tmp2 | awk /./ > tmp3

# This line removes the lines containing the FASTA headers
#
cat tmp3 | grep -v ">" > $OUTFILE

# This line creates the headers.txt file matching the order of the sequences in the output.fasta file
# 
cat tmp3 | grep ">" > headers.txt

# Cleanup
rm tmp1 tmp2 tmp3
echo "Processing complete."
echo ""




# That's it.  Nothing more.  Why are you still here?  Go Home!  Bueller?  Bueller?
