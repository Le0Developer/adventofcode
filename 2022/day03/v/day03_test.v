module main

fn test_challenge_a() ? {
	input_lines := ['vJrwpWtwJgWrhcsFMMfFFhFp', 'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
		'PmmdzqPrVvPwwTWBwg', 'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn', 'ttgJtRGJQctTZtZT',
		'CrZsJsPPZsGzwwsLwLmpwMDw']
	assert (challenge_a(input_lines)?) == 157
}

fn test_challenge_b() ? {
	input_lines := ['vJrwpWtwJgWrhcsFMMfFFhFp', 'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL',
		'PmmdzqPrVvPwwTWBwg', 'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn', 'ttgJtRGJQctTZtZT',
		'CrZsJsPPZsGzwwsLwLmpwMDw']
	assert (challenge_b(input_lines)?) == 70
}
