module main

fn test_challenge_a() ? {
	input_lines := ['[({(<(())[]>[[{[]{<()<>>', '[(()[<>])]({[<{<<[]>>(', '{([(<{}[<>[]}>{[]{[(<()>',
		'(((({<>}<{<{<>}{[]{[]{}', '[[<[([]))<([[{}[[()]]]', '[{[{({}]{}}([{[{{{}}([]',
		'{<[[]]>}<{[{[{[]{()[[[]', '[<(<(<(<{}))><([]([]()', '<{([([[(<>()){}]>(<<{{',
		'<{([{{}}[<[[[<>{}]]]>[]]']
	assert (challenge_a(input_lines) ?) == 26397
}

fn test_challenge_b() ? {
	input_lines := ['[({(<(())[]>[[{[]{<()<>>', '[(()[<>])]({[<{<<[]>>(', '{([(<{}[<>[]}>{[]{[(<()>',
		'(((({<>}<{<{<>}{[]{[]{}', '[[<[([]))<([[{}[[()]]]', '[{[{({}]{}}([{[{{{}}([]',
		'{<[[]]>}<{[{[{[]{()[[[]', '[<(<(<(<{}))><([]([]()', '<{([([[(<>()){}]>(<<{{',
		'<{([{{}}[<[[[<>{}]]]>[]]']
	assert (challenge_b(input_lines) ?) == 288957
}
