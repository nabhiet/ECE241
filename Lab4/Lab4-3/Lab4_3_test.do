vlib work
vlog Lab4_3.v
vsim Lab4_3
log {/*}
add wave {/*}

# resetting the system
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {SW[9]} 1
force {KEY[0]} 0
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0
run 10ns

# parallelloadn = 0, value of datain is stored
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 0
force {KEY[2]} 0
force {KEY[3]} 0
run 10ns

# nothing
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 0
run 10ns

# parallelloadn = 1, rotateright = 1, asright = 0 --> shift right --> output = 10011111
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 10ns

# nothing
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 0
run 10ns

# parallelloadn = 1, rotateright = 0 --> shift left --> output = 00111111
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 1
run 10ns

# nothing
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 0
force {KEY[3]} 1
run 10ns

# parallelloadn = 1, rotateright = 1, asright = 1 --> arithmetic shift right --> output = 00111111
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 10ns

# nothing
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {SW[9]} 0
force {KEY[0]} 0
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 10ns

# parallelloadn = 1, rotateright = 1, asright = 1 --> arithmetic shift right --> output = 00011111
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {SW[9]} 0
force {KEY[0]} 1
force {KEY[1]} 1
force {KEY[2]} 1
force {KEY[3]} 1
run 10ns

