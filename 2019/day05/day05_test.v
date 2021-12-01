module main

fn test_challenge_a() ? {
	input_lines := ['1002,4,3,4,33']
	assert (challenge_a(input_lines) ?) == -1
}

struct TestData {
	input   string
	input_0 int
	input_1 int
	input_8 int
	input_9 int
}

fn test_challenge_b() ? {
	test_data := [
		TestData{'3,9,8,9,10,9,4,9,99,-1,8', 0, 0, 1, 0},
		TestData{'3,9,7,9,10,9,4,9,99,-1,8', 1, 1, 0, 0},
		TestData{'3,3,1108,-1,8,3,4,3,99', 0, 0, 1, 0},
		TestData{'3,3,1107,-1,8,3,4,3,99', 1, 1, 0, 0},
		TestData{'3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9', 0, 1, 1, 1},
		TestData{'3,3,1105,-1,9,1101,0,0,12,4,12,99,1', 0, 1, 1, 1},
		TestData{'3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99', 999, 999, 1000, 1001},
	]
	for test in test_data {
		println(test)
		input_lines := [test.input]
		assert (challenge_b(input_lines, 0) ?) == test.input_0
		assert (challenge_b(input_lines, 1) ?) == test.input_1
		assert (challenge_b(input_lines, 8) ?) == test.input_8
		assert (challenge_b(input_lines, 9) ?) == test.input_9
	}
}
