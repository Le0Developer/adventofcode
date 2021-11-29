module main

fn test_solve_a() {
	input := ['mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X', 'mem[8] = 11', 'mem[7] = 101',
		'mem[8] = 0']
	assert solve_a(input) == 165
}

fn test_solve_b() {
	input := ['mask = 000000000000000000000000000000X1001X', 'mem[42] = 100',
		'mask = 00000000000000000000000000000000X0XX', 'mem[26] = 1']
	assert solve_b(input) == 208
}
