#!/bin/ksh
################################################################################
#@
#@ Script Name:        cl.sh
#@
#@ Author:             Tom Zhang
#@
#@ Description:
#@   This script is used to collect the lines in a specified path.
#@
#@ Usage:
#@   cl.sh -h       : print how to use this command
#@   cl.sh -l /dir  : list all the files and then show file numbers and code lines.
#@   cl.sh /dir     : only show the file number and code lines in the dir.
#@
#@ Notes:
#@   In all the functions, return value 0 means success, 1 stands for fail, This
#@ is also stardard for system shell command.
#@
#@ Histoty:
#@ 08/7/2007  Tom Zhang    Intial creation.
#@ 
################################################################################

#
#@ Modify this value for each new version.
#
VERSION=1.0

#
#@ Default path to be searched.
#
ROOT_PATH=$PWD

#
#@ Command line process.
#
if [ $# -ge 1 ] && [ "$1" = "-h" ]
then
		echo "Usage: cl [-h] [-l] [DIR_PATH]"
        exit 0
fi

if [ $# -ge 1 ] && [ "$1" != "-l" ]
then
	ROOT_PATH=$1
fi

optionl="0"

if [ $# -ge 1 ] && [ "$1" = "-l" ]
then
	optionl="1"
fi

if [ $# -ge 2 ] && [ "$1" = "-l" ]
then
	ROOT_PATH=$2
	optionl="1"
fi

#
# Check src dir exist
#
if [ ! -d $ROOT_PATH ]
then
	echo "Specified dir $ROOT_PATH doesn't exist!"
	exit 1
fi

#
#@ Regular expression when find the exact source files. Support *.h, *.cc, *.cpp and makefile
#
REG='\.sh|\.h\|\.cc\|[Mm]akefile\|\.cpp\|\.c\|\.cfg'

#
#@ Except the cvs and svn directory files
#
ARG=".svn\|cvs"

#
#@ Optional list
#

if [ "$optionl" = "1" ]
then
	find $ROOT_PATH -type f | grep $REG | grep -v $ARG | xargs wc -l | grep -v "total"
fi

echo ""

echo "IN <$ROOT_PATH> DIRECTORY"

echo ""

#
#@ Caculate the file numbers
#
find $ROOT_PATH -type f | grep $REG | grep -v $ARG | wc -l | awk '{print "TOTAL ["$1"] FILES;"}'

echo ""

#
#@ Caculate the code lines.
#
find $ROOT_PATH -type f | grep $REG | grep -v $ARG | xargs wc -l | 

awk '$2=="total" {sum += $1} END {print "TOTAL ["sum"] LINES."}'

echo ""

#
#@ Check the command result.
#
if [ $? -ne 0 ]
then
	echo "code lines execution error".
	exit 1
fi

exit 0


