module main

fn test_challenge_a() ? {
	input_lines := ['A Y', 'B X', 'C Z']
	assert (challenge_a(input_lines)?) == 15
}

fn test_challenge_b() ? {
	input_lines := ['A Y', 'B X', 'C Z']
	assert (challenge_b(input_lines)?) == 12
}
