vlib work
vlog Lab6_2.v
vsim Lab6_2
log {/*}
add wave {/*}

# reset system
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 0
force {KEY[0]} 0
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# input A = 20
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 0
force {KEY[0]} 1
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# load A 
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 1
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# input B = 4
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 0
force {KEY[0]} 1
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# load B
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 1
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# input C = 12
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 0
force {KEY[0]} 1
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# load C
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 1
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# input x = 2
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 0
force {KEY[0]} 1
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# load x
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[1]} 1
force {KEY[0]} 1
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# allow for computations
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[1]} 0
force {KEY[0]} 1
force CLOCK_50 0 0ns , 1 {5ns} -r 10ns
run 60 ns