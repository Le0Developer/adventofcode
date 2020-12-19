fn test_solve_a() {
	input := ['0: 4 1 5', '1: 2 3 | 3 2', '2: 4 4 | 5 5', '3: 4 5 | 5 4', '4: "a"', '5: "b"', '',
		'ababbb', 'bababa', 'abbbab', 'aaabbb', 'aaaabbb']
	assert solve_a(input) == 2
}

// Not really possible to test solve_b() without actual test data
// which I'm not gonna make public...
// Feel free to PR
