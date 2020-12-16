module main

fn test_solve_a() {
	values := [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277,
		309, 576]
	assert solve_a(values, 5) == 127
}

fn test_solve_b() {
	values := [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277,
		309, 576]
	assert solve_b(values, 5) == 62
}
