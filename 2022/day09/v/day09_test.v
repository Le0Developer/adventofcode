module main

fn test_challenge_a() ? {
	input_lines := ['R 4', 'U 4', 'L 3', 'D 1', 'R 4', 'D 1', 'L 5', 'R 2']
	assert (challenge_a(input_lines)?) == 13
}

fn test_challenge_b() ? {
	input_lines := ['R 5', 'U 8', 'L 8', 'D 3', 'R 17', 'D 10', 'L 25', 'U 20']
	assert (challenge_b(input_lines)?) == 36
}
