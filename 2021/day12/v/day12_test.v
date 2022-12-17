module main

fn test_challenge_a() ? {
	input_lines_1 := ['start-A', 'start-b', 'A-c', 'A-b', 'b-d', 'A-end', 'b-end']
	assert (challenge_a(input_lines_1)?) == 10
	input_lines_2 := ['dc-end', 'HN-start', 'start-kj', 'dc-start', 'dc-HN', 'LN-dc', 'HN-end',
		'kj-sa', 'kj-HN', 'kj-dc']
	assert (challenge_a(input_lines_2)?) == 19
	input_lines_3 := ['fs-end', 'he-DX', 'fs-he', 'start-DX', 'pj-DX', 'end-zg', 'zg-sl', 'zg-pj',
		'pj-he', 'RW-he', 'fs-DX', 'pj-RW', 'zg-RW', 'start-pj', 'he-WI', 'zg-he', 'pj-fs',
		'start-RW']
	assert (challenge_a(input_lines_3)?) == 226
}

fn test_challenge_b() ? {
	input_lines_1 := ['start-A', 'start-b', 'A-c', 'A-b', 'b-d', 'A-end', 'b-end']
	assert (challenge_b(input_lines_1)?) == 36
	input_lines_2 := ['dc-end', 'HN-start', 'start-kj', 'dc-start', 'dc-HN', 'LN-dc', 'HN-end',
		'kj-sa', 'kj-HN', 'kj-dc']
	assert (challenge_b(input_lines_2)?) == 103
	input_lines_3 := ['fs-end', 'he-DX', 'fs-he', 'start-DX', 'pj-DX', 'end-zg', 'zg-sl', 'zg-pj',
		'pj-he', 'RW-he', 'fs-DX', 'pj-RW', 'zg-RW', 'start-pj', 'he-WI', 'zg-he', 'pj-fs',
		'start-RW']
	assert (challenge_b(input_lines_3)?) == 3509
}
