module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut score := 0
	for line in input_lines {
		v1 := line[0] - 0x41
		v2 := line[2] - 0x58
		score += v2 + 1
		if v1 == v2 {
			score += 3
		} else if v1 == (v2 + 2) % 3 {
			score += 6
		}
	}
	return score
}

fn challenge_b(input_lines []string) ?i64 {
	mut score := 0
	for line in input_lines {
		v1 := line[0] - 0x41
		v2 := line[2] - 0x58
		score += (v1 + v2 + 2) % 3 + 1
		if v2 == 1 {
			score += 3
		} else if v2 == 2 {
			score += 6
		}
	}
	return score
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2022 day 02')
	fp.version('v0.1.0')
	fp.skip_executable()
	fp.limit_free_args_to_exactly(1)!
	is_b := fp.bool('b', `b`, false, 'b challenge')
	// more options here
	additional_args := fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}
	input_filename := additional_args[0]
	input_lines := os.read_lines(input_filename)!
	solution := if !is_b { challenge_a(input_lines)? } else { challenge_b(input_lines)? }
	println('Solution is ${solution}')
}
