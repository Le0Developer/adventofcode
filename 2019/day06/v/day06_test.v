module main

fn test_challenge_a() ? {
	input_lines := ['COM)B', 'B)C', 'C)D', 'D)E', 'E)F', 'B)G', 'G)H', 'D)I', 'E)J', 'J)K', 'K)L']
	assert (challenge_a(input_lines)?) == 42
	assert (challenge_a(input_lines.reverse())?) == 42
}

fn test_challenge_b() ? {
	input_lines := ['COM)B', 'B)C', 'C)D', 'D)E', 'E)F', 'B)G', 'G)H', 'D)I', 'E)J', 'J)K', 'K)L',
		'K)YOU', 'I)SAN']
	assert (challenge_b(input_lines)?) == 4
}
