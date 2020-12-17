module main

fn test_solve_a() {
	input := ['.#.', '..#', '###']
	assert solve_a(input) == 112
}

fn test_solve_b() {
	input := ['.#.', '..#', '###']
	assert solve_b(input) == 848
}
