#!/bin/bash

num_of_docks=$(docker ps -q | wc -l)
terminate_containers=()

# Iterate through runing containers and check their time unit and amount of time they are up
for i in $(seq 1 $num_of_docks); do

	container_id=$(docker ps --format "{{.ID}}" | tail -n+$i | head -n1)
	time_unit=$(docker ps --format "{{.Status}}" | tail -n+$i | head -n1)
	time_amount=$(echo "$time_unit" | cut -d' ' -f2)
	# echo "$container_id, $time_unit, $time_amount" ## check the output

	# Check if a "time_amount" variable is a number
	re='^[0-9]+$'
	if ! [[ $time_amount =~ $re ]] ; then
		time_amount=0
	fi

	# Check if the time unit is days or hours is days automatically terminate else if hours then check how much
	if [[ $time_unit == *"second"* ]] || [[ $time_unit == *"minute"* ]]; then 
		continue
	elif [[ $time_unit == *"hour"* ]]; then
		if [ $time_amount > 5 ]; then # time in hours after which containers will be terminated
			terminate_containers+=($container_id) 
		fi
	else 
		terminate_containers+=($container_id)
	fi

done

for container in "${terminate_containers[@]}"; do
	docker rm -f $container
done

exit 0

