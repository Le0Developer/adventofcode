module main

fn test_solve_a() {
	input := ['nop +0', 'acc +1', 'jmp +4', 'acc +3', 'jmp -3', 'acc -99', 'acc +1', 'jmp -4',
		'acc +6',
	]
	instructions := parse(input)
	ok, solution := solve_a(instructions)
	assert !ok
	assert solution == 5
}

fn test_solve_b() {
	input := ['nop +0', 'acc +1', 'jmp +4', 'acc +3', 'jmp -3', 'acc -99', 'acc +1', 'jmp -4',
		'acc +6',
	]
	instructions := parse(input)
	ok, solution := solve_b(instructions)
	assert ok
	assert solution == 8
}
