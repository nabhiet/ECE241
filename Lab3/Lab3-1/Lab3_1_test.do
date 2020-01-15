vlib work

vlog Lab3_1.v

vsim Lab3_1

log {/*}

add wave {/*}

# the output will follow SW[0]
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 0
run 10ns

# the output will follow SW[0]
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 0
run 10ns

# the output will follow SW[1]
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 1
run 10ns

# the output will follow SW[1]
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[9]} 0
force {SW[8]} 0
force {SW[7]} 1
run 10ns

# the output will follow SW[2]
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 0
run 10ns

# the output will follow SW[2]
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 0
force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 0
run 10ns

# the output will follow SW[3]
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 1
run 10ns

# the output will follow SW[3]
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1
force {SW[4]} 1
force {SW[5]} 1
force {SW[9]} 0
force {SW[8]} 1
force {SW[7]} 1
run 10ns

# the output will follow SW[4]
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 0
force {SW[5]} 1
force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 0
run 10ns

# the output will follow SW[4]
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 0
run 10ns

# the output will follow SW[5]
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 0
force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 1
run 10ns

# the output will follow SW[5]
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0
force {SW[4]} 1
force {SW[5]} 1
force {SW[9]} 1
force {SW[8]} 0
force {SW[7]} 1
run 10ns
