module main

fn test_challenge_a() ? {
	input_lines := ['16,1,2,0,4,2,7,1,2,14']
	assert (challenge_a(input_lines)?) == 37
}

fn test_challenge_b() ? {
	input_lines := ['16,1,2,0,4,2,7,1,2,14']
	assert (challenge_b(input_lines)?) == 168
}
