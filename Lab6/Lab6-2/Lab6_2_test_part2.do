vlib work
vlog Lab6_2.v
vsim part2
log {/*}
add wave {/*}

# reset system
force data_in 00000000
force go 0
force resetn 0
force clk 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# input A = 20
force data_in 00010100
force go 0
force resetn 1
force clk 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# load A 
force data_in 00010100
force go 1
force resetn 1
force clk 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# input B = 4
force data_in 00000100
force go 0
force resetn 1
force clk 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# load B
force data_in 00000100
force go 1
force resetn 1
force clk 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# input C = 12
force data_in 00001100
force go 0
force resetn 1
force clk 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# load C
force data_in 00001100
force go 1
force resetn 1
force clk 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# input x = 2
force data_in 00000010
force go 0
force resetn 1
force clk 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# load x
force data_in 00000010
force go 1
force resetn 1
force clk 0 0ns , 1 {5ns} -r 10ns
run 10 ns

# allow for computations
force data_in 00000000
force go 0
force resetn 1
force clk 0 0ns , 1 {5ns} -r 10ns
run 60 ns