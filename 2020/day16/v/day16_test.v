module main

fn test_solve_a() {
	input := ['class: 1-3 or 5-7', 'row: 6-11 or 33-44', 'seat: 13-40 or 45-50', '', 'your ticket:',
		'7,1,14', '', 'nearby tickets:', '7,3,47', '40,4,50', '55,2,20', '38,6,12']
	assert solve_a(input) == 71
}

fn test_solve_b() {
	input := ['departure class: 1-3 or 5-7', 'departure row: 6-11 or 33-44',
		'departure seat: 13-40 or 45-50', '', 'your ticket:', '7,1,14', '', 'nearby tickets:',
		'7,3,47', '40,4,50', '55,2,20', '38,6,12']
	assert solve_b(input) == 98
}
