#!/bin/bash
stty -echoctl
trap " " 2 20
i=3
echo "Hello lets play a game"
sleep 1
echo "I will choose a number between 0-9 and you should guess it"
random=$(($RANDOM % 10))
sleep 2
echo -e "OK i choose a number now you try to guess it you have \033[1;32m$i\033[m guesses:"
for (( i; i>0; i-- ))
do
	read ans
	until [[ $ans == +([0-9]) ]]; do read -p "please enter a number: " ans; done
	while [ $ans -gt 9 -o $ans -lt 0 ]; do read -p "Invalid number try again: " ans; done;
	if [[ $ans == $random ]]; then echo -e "\033[1;34;42mYou are damn good!\033[m"; exit;
	elif [[ $i > 1 ]]; then echo -e "wrong you have got \033[1;32m$((i-1))\033[m guesses try again:"
	fi
done
echo -e "\033[31mSorry out of guesses\033[m"
echo -e "\033[1;32mThe number is: $random\033[m"
trap 2 20
stty echoctl
