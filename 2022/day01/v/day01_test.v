module main

fn test_challenge_a() ? {
	input_lines := ['1000', '2000', '3000', '', '4000', '', '5000', '6000', '', '7000', '8000', '9000', '', '10000']
	assert (challenge_a(input_lines)?) == 24000
}

fn test_challenge_b() ? {
	input_lines := ['1000', '2000', '3000', '', '4000', '', '5000', '6000', '', '7000', '8000', '9000', '', '10000']
	assert (challenge_b(input_lines)?) == 41000
}
