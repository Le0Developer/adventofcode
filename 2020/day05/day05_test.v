module main

fn test_solve_a() {
	input := ['BFFFBBFRRR', 'FFFBBBFRRR', 'BBFFBBFRLL']
	passes := parse(input)
	assert solve_a(passes) == 820
}

fn test_solve_b() {
	// TODO: get real data to test this
	input := ['BFFFBBFRRR', 'FFFBBBFRRR', 'BBFFBBFRLL']
	passes := parse(input)
	assert solve_b(passes) == -1
}
