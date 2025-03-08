package main

import (
	"encoding/gob"
	"fmt"
	"net"
	"os"
	"time"

	"github.com/David-Antunes/gone-proxy/xdp"
	"github.com/google/gopacket"
	"github.com/google/gopacket/layers"
)

func main() {

	if len(os.Args) == 1 {
		fmt.Println("missing socket id")
		return
	}

	if len(os.Args) > 2 {
		fmt.Println("too many arguments")
		return
	}

	conn, err := net.Dial("unix", os.Args[1])

	if err != nil {
		panic(err)
	}

	dec := gob.NewDecoder(conn)
	enc := gob.NewEncoder(conn)

	channel := make(chan *xdp.Frame, 1000)

	go func() {
		for {
			frame := <-channel

			err := enc.Encode(&frame)
			if err != nil {
				panic(err)
			}
		}
	}()

	for {
		var frame *xdp.Frame
		err := dec.Decode(&frame)
		fmt.Println("received")
		if err != nil {
			panic(err)
		}
		packet := gopacket.NewPacket(frame.FramePointer, layers.LinkTypeEthernet, gopacket.NoCopy)

		if ipLayer := packet.Layer(layers.LayerTypeIPv4); ipLayer != nil {
			ip := ipLayer.(*layers.IPv4)

			if ip.SrcIP.String() == "10.1.0.101" {
				go func() {
					time.Sleep(10 * time.Millisecond)
					fmt.Println("delayed")
					channel <- frame
				}()
			} else {
				channel <- frame
			}
		} else {
			channel <- frame
		}
	}
}
