#!/bin/bash

read -p "full path to directory: " path
cd path
function R
{
	for FILE in *; do
		if [[ -d $FILE ]]; then
			cd ./$FILE
			$(R) 
			cd ..
		elif [[ $FILE = *.sh ]]; then
			chmod 700 $FILE
		fi
	done
}
while [ true ]; do
	sleep 1
	R
done
