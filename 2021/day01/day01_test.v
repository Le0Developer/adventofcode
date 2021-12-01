module main

fn test_challenge_a() ? {
	input_lines := ['199', '200', '208', '210', '200', '207', '240', '269', '260', '263']
	assert (challenge_a(input_lines) ?) == 7
}

fn test_challenge_b() ? {
	input_lines := ['199', '200', '208', '210', '200', '207', '240', '269', '260', '263']
	assert (challenge_b(input_lines) ?) == 5
}
