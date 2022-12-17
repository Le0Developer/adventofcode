module main

fn test_challenge_a() ? {
	input_lines := ['2-4,6-8', '2-3,4-5', '5-7,7-9', '2-8,3-7', '6-6,4-6', '2-6,4-8']
	assert (challenge_a(input_lines)?) == 2
}

fn test_challenge_b() ? {
	input_lines := ['2-4,6-8', '2-3,4-5', '5-7,7-9', '2-8,3-7', '6-6,4-6', '2-6,4-8']
	assert (challenge_b(input_lines)?) == 4
}
