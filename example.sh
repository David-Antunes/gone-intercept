#!/bin/bash

docker run -it --workdir="/app" -v $(pwd):/app golang go build -buildvcs=false

docker build -t ping .

gone-cli node -- docker run --rm -d --network gone_net --name ping-1 --hostname ping-1 --ip 10.1.0.100 ping
gone-cli node -- docker run --rm -d --network gone_net --name ping-2 --hostname ping-2 --ip 10.1.0.101 ping
gone-cli node -- docker run --rm -d --network gone_net --name ping-3 --hostname ping-3 --ip 10.1.0.102 ping
gone-cli node -- docker run --rm -d --network gone_net --name ping-4 --hostname ping-4 --ip 10.1.0.103 ping
gone-cli node -- docker run --rm -d --network gone_net --name ping-5 --hostname ping-5 --ip 10.1.0.104 ping
gone-cli node -- docker run --rm -d --network gone_net --name ping-6 --hostname ping-6 --ip 10.1.0.105 ping
gone-cli node -- docker run --rm -d --network gone_net --name ping-7 --hostname ping-7 --ip 10.1.0.106 ping
gone-cli node -- docker run --rm -d --network gone_net --name ping-8 --hostname ping-8 --ip 10.1.0.107 ping
gone-cli node -- docker run --rm -d --network gone_net --name ping-9 --hostname ping-9 --ip 10.1.0.108 ping
gone-cli node -- docker run --rm -d --network gone_net --name ping-10 --hostname ping-10 --ip 10.1.0.109 ping

gone-cli bridge bridge1
gone-cli bridge bridge2
gone-cli bridge bridge3
gone-cli bridge bridge4
gone-cli bridge bridge5

gone-cli router router1
gone-cli router router2
gone-cli router router3

gone-cli connect -w 1G -n ping-1 bridge1
gone-cli connect -w 1G -n ping-2 bridge1

gone-cli connect -w 1G -n ping-3 bridge2
gone-cli connect -w 1G -n ping-4 bridge2

gone-cli connect -w 1G -n ping-5 bridge3
gone-cli connect -w 1G -n ping-6 bridge3

gone-cli connect -w 1G -n ping-7 bridge4
gone-cli connect -w 1G -n ping-8 bridge4

gone-cli connect -w 1G -n ping-9 bridge5
gone-cli connect -w 1G -n ping-10 bridge5

gone-cli connect -w 1G -b bridge1 router1
gone-cli connect -w 1G -b bridge2 router1

gone-cli connect -w 1G -b bridge3 router2
gone-cli connect -w 1G -b bridge4 router2

gone-cli connect -w 1G -b bridge5 router3
gone-cli connect -w 1G -r router1 router2

gone-cli connect -w 1G -r router2 router3

gone-cli connect -w 1G -r router3 router1

gone-cli propagate router3

gone-cli intercept -i example -n ping-1 

gone-cli unpause -a

sudo go run intercept.go /tmp/example.intercept
