vlib work
vlog Lab6_1.v
vsim Lab6_1
log {/*}
add wave {/*}

# reset system
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# test sequence 1111
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0 0ns , 1 {5ns} -r 10ns
run 50 ns

# reset system
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# test sequence 1101
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0 0ns , 1 {5ns} -r 10ns
run 20 ns

# test sequence 1101
force {SW[1]} 0
force {SW[0]} 1
force {KEY[0]} 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# test sequence 1101
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0 0ns , 1 {5ns} -r 10ns
run 20 ns

