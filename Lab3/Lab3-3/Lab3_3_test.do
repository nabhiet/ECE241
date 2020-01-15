vlib work

vlog Lab3_3.v

vsim Lab3_3

log {/*}

add wave {/*}

# test for case 0: 12(A) + 6(B) = 18
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 0
run 10ns

# test for case 1: 12(A) + 5(B) = 17
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
force {KEY[2]} 0
force {KEY[1]} 0
force {KEY[0]} 1
run 10ns

# test for case 2: {0101 NAND 1111, 0101 XNOR 1111} = 10100101
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 0
run 10ns

# test for case 3a: at least 1 bit is 1 so output = 00001111 
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1
run 10ns

# test for case 3b: no bit is 1 so output = 00000000 
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1
run 10ns

# test for case 4a: 1 bit of A is 1 and 2 bits of B is 1 so output = 01110000
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 0
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 0
force {SW[0]} 1
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0
run 10ns

# test for case 4b: 2 bits of A is 1 and 1 bit of B is 1 so output = 00000000
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0
run 10ns

# test for case 5: output = 01110001
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 0
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 1
run 10ns
