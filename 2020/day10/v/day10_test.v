module main

fn test_solve_a() {
	mut inputs := [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
	assert solve_a(mut inputs) == 35
}

fn test_solve_b() {
	mut inputs := [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
	assert solve_b(mut inputs) == 8
}
