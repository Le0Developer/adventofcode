module main

fn test_challenge_a() ? {
	input_lines := ['2199943210', '3987894921', '9856789892', '8767896789', '9899965678']
	assert (challenge_a(input_lines) ?) == 15
}

fn test_challenge_b() ? {
	input_lines := ['2199943210', '3987894921', '9856789892', '8767896789', '9899965678']
	assert (challenge_b(input_lines) ?) == 1134
}
