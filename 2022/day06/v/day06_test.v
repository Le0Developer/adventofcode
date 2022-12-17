module main

fn test_challenge_a() ? {
	assert (challenge_a(['mjqjpqmgbljsphdztnvjfqwrcgsmlb'])?) == 7
	assert (challenge_a(['bvwbjplbgvbhsrlpgdmjqwftvncz'])?) == 5
	assert (challenge_a(['nppdvjthqldpwncqszvftbrmjlhg'])?) == 6
	assert (challenge_a(['nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'])?) == 10
	assert (challenge_a(['zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'])?) == 11
}

fn test_challenge_b() ? {
	assert (challenge_b(['mjqjpqmgbljsphdztnvjfqwrcgsmlb'])?) == 19
	assert (challenge_b(['bvwbjplbgvbhsrlpgdmjqwftvncz'])?) == 23
	assert (challenge_b(['nppdvjthqldpwncqszvftbrmjlhg'])?) == 23
	assert (challenge_b(['nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'])?) == 29
	assert (challenge_b(['zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'])?) == 26
}
