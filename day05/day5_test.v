module main

fn solve_a_test() {
	input := ['BFFFBBFRRR', 'FFFBBBFRRR', 'BBFFBBFRLL']
	passes := parse(input)
	assert solve_a(passes) == 820
}

fn solve_b_test() {
	// TODO: get real data to test this
	input := ['BFFFBBFRRR', 'FFFBBBFRRR', 'BBFFBBFRLL']
	passes := parse(input)
	assert solve_b(passes) == -1
}
