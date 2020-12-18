module main

fn test_solve_a() {
	inputs := ['F10', 'N3', 'F7', 'R90', 'F11']
	assert solve_a(inputs) == 25
}

fn test_solve_b() {
	inputs := ['F10', 'N3', 'F7', 'R90', 'F11']
	assert solve_b(inputs) == 286
}
