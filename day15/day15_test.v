module main

fn test_solve() {
	// Test solve2 because it's faster
	//
	// I don't test it with 30,000,000 because it takes too long
	input := ['0,3,6']
	assert solve2(input, 2020) == 436
}
