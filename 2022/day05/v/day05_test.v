module main

fn test_challenge_a() ? {
	input_lines := ['    [D]    ', '[N] [C]    ', '[Z] [M] [P]', ' 1   2   3 ', '',
		'move 1 from 2 to 1', 'move 3 from 1 to 3', 'move 2 from 2 to 1', 'move 1 from 1 to 2']
	assert (challenge_a(input_lines)?) == 'CMZ'
}

fn test_challenge_b() ? {
	input_lines := ['    [D]    ', '[N] [C]    ', '[Z] [M] [P]', ' 1   2   3 ', '',
		'move 1 from 2 to 1', 'move 3 from 1 to 3', 'move 2 from 2 to 1', 'move 1 from 1 to 2']
	assert (challenge_b(input_lines)?) == 'MCD'
}
