#!/bin/bash

git add .

read -p "Message to commit: " message
git commit -m "$message" .

echo "pulling last changes"
git pull

if [ $? == 0 ]; then 
	read -p "Do you want to push the changes (y/n)?" ans
	case $ans in
	[Yy]) git push;;
	   *) continue;; 
	esac
	exit 0
fi
