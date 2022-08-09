#!/bin/sh

# compile verilog
yosys -D LEDS_NR=6 -p "read_verilog blinky.v; synth_gowin -json blinky.json"

# place and route
nextpnr-gowin --json blinky.json --write pnrblinky.json --device GW1NR-LV9QN88PC6/I5 --cst tangnano9k.cst

# pack
gowin_pack -d GW1N-9C -o pack.fs pnrblinky.json

# upload
sudo openFPGALoader -b tangnano9k pack.fs
