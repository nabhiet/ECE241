# set the working dir, where all compiled verilog goes
vlib work

vlog Lab2_2.v

vsim v7432

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {pin1} 0
force {pin2} 0
#run simulation for a few ns
run 10ns

force {pin1} 0
force {pin2} 1
run 10ns

force {pin1} 1
force {pin2} 0
run 10ns

force {pin1} 1
force {pin2} 1
run 10ns
