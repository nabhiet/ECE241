vlib work
vlog Lab4_2.v
vsim Lab4_2
log {/*}
add wave {/*}

# resetting the system and case 1: 8(data) + 0(last3bitsofregout) = 8(ledr)
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1
force {SW[9]} 0
run 10ns

# testing case 1: 6(data) + 0(last3bitsofregout) = 6(ledr)
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 0
force {SW[9]} 1
run 10ns

# testing case 1: 10(data) + 6(last3bitsofregout) = 16(ledr)
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0
force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1
force {SW[9]} 1
run 10ns

# testing case 1: 12(data) + 6(last3bitsofregout) = 18(ledr)
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 0
force {KEY[3]} 0
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 0
force {SW[9]} 1
run 10ns

# testing case 5: input = 11110010, output = 11111101
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[3]} 1
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1
force {SW[9]} 1
run 10ns

# testing case 6: hold current value of register, output = 00010010
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0
force {SW[9]} 1
run 10ns

# testing case 6: keep holding current value of register, output = 00010010
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 1
force {SW[9]} 1
run 10ns

# testing case 6: keep holding current value of register, output = 00010010
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
force {KEY[3]} 1
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0
force {SW[9]} 1
run 10ns

