module main

const (
	lines = ['abc', '', 'a', 'b', 'c', '', 'ab', 'ac', '', 'a', 'a', 'a', 'a', '', 'b']
)

fn test_solve_a() {
	assert solve_a(lines) == 11
}

fn test_solve_b() {
	assert solve_b(lines) == 6
}
