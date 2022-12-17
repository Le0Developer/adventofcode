module main

fn test_challenge_a() ? {
	input_lines := ['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']
	assert (challenge_a(input_lines)?) == 150
}

fn test_challenge_b() ? {
	input_lines := ['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']
	assert (challenge_b(input_lines)?) == 900
}
