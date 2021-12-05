module main

fn test_solve_a() {
	input := ['R75,D30,R83,U83,L12,D49,R71,U7,L72', 'U62,R66,U55,R34,D71,R55,D58,R83']
	assert solve_a(input) == 159
}

fn test_solve_b() {
	input := ['R75,D30,R83,U83,L12,D49,R71,U7,L72', 'U62,R66,U55,R34,D71,R55,D58,R83']
	assert solve_b(input) == 610
}
