vlib work

vlog Lab5_1.v

vsim Lab5_1

log {/*}

add wave {/*}

# clear system
force {SW[1]} 0
force {SW[0]} 0
force {KEY[0]} 1
run 10ns

# nothing
force {SW[1]} 0
force {SW[0]} 1
force {KEY[0]} 0
run 10ns

# count 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
run 10ns

# nothing
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0
run 10ns

# count 2
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
run 10ns

# nothing
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0
run 10ns

# count 3
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
run 10ns

# nothing
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0
run 10ns

# count 4
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
run 10ns

# nothing
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0
run 10ns

# count 5
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 1
run 10ns

# nothing
force {SW[1]} 1
force {SW[0]} 1
force {KEY[0]} 0
run 10ns