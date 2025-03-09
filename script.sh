#!/bin/bash


sleep 3

ENDPOINTS=("ping-1" "ping-2" "ping-3" "ping-4" "ping-5" "ping-6" "ping-7" "ping-8" "ping-9" "ping-10")

for host in ${ENDPOINTS[@]}; do

  if [ ! $(hostname) = $host ]; then
    echo "Started ping for $host"
    sleep 0.125
    ping -i 0.5 $host > $host.ping &
  fi
done

wait
