# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in Lab2_1.v to working dir
# could also have multiple verilog files
vlog Lab2_1.v

#load simulation using Lab2_1 as the top level simulation module
vsim Lab2_1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

# select follows x
force {SW[0]} 0
force {SW[1]} 0
force {SW[9]} 0
#run simulation for a few ns
run 10ns

# select follows x
force {SW[0]} 1
force {SW[1]} 0
force {SW[9]} 0
run 10ns

# select follows y
force {SW[0]} 0
force {SW[1]} 0
force {SW[9]} 1
run 10ns

# select follows y
force {SW[0]} 0
force {SW[1]} 1
force {SW[9]} 1
run 10ns
