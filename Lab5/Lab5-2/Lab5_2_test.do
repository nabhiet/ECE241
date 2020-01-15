vlib work

vlog Lab5_2.v

vsim Lab5_2

log {/*}

add wave {/*}


force {KEY[0]} 0
force {SW[1]} 0
force {SW[0]} 0
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 20 ns

force {KEY[0]} 1
force {SW[1]} 0
force {SW[0]} 1
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 2000 ns

force {KEY[0]} 1
force {SW[1]} 0
force {SW[0]} 0
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 200 ns


