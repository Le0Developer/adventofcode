module main

fn test_challenge_a() ? {
	input_lines := ['3,4,3,1,2']
	assert (challenge_a(input_lines)?) == 5934
}

fn test_challenge_b() ? {
	input_lines := ['3,4,3,1,2']
	assert (challenge_b(input_lines)?) == 26984457539
}
