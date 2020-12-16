module main

fn test_parse() {
	policies = parse(['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc'])
	policy = policies[0]
	assert policy.value_0 == 1
	assert policy.value_1 == 3
	assert policy.char == `a`
	assert policy.password == 'abcde'
}

fn test_solve_a() {
	assert solve_a(['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc']) == 2
}

fn test_solve_b() {
	assert solve_b(['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc']) == 1
}
