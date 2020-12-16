module main

fn test_solve_a() {
	input := ['939', '7,13,x,x,59,x,31,19']
	assert solve_a(input) == 295
}

fn test_solve_b() {
	input := ['939', '7,13,x,x,59,x,31,19']
	assert solve_b(input) == 1068781
}
