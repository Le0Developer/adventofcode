module main

fn test_challenge_a() ? {
	input_lines := ['00100', '11110', '10110', '10111', '10101', '01111', '00111', '11100', '10000',
		'11001', '00010', '01010']
	assert (challenge_a(input_lines) ?) == 198
}

fn test_challenge_b() ? {
	input_lines := ['00100', '11110', '10110', '10111', '10101', '01111', '00111', '11100', '10000',
		'11001', '00010', '01010']
	assert (challenge_b(input_lines) ?) == 230
}
