module main

fn test_challenge_a() ? {
	input_lines := ['30373', '25512', '65332', '33549', '35390']
	assert (challenge_a(input_lines)?) == 21
}

fn test_challenge_b() ? {
	input_lines := ['30373', '25512', '65332', '33549', '35390']
	assert (challenge_b(input_lines)?) == 8
}
