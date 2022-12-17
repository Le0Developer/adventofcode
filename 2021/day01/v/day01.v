module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	input_ints := input_lines.map(it.int())
	mut previous := input_ints[0]
	mut total := 0
	for line in input_ints {
		if line > previous {
			total++
		}
		previous = line
	}
	return total
}

fn challenge_b(input_lines []string) ?i64 {
	input_ints := input_lines.map(it.int())
	mut previous1 := input_ints[0]
	mut previous2 := input_ints[1]
	mut previous_sum := input_ints[0] + input_ints[1] + input_ints[2]
	mut total := 0
	for line in input_ints[2..] {
		sum := previous1 + previous2 + line
		if sum > previous_sum {
			total++
		}
		previous_sum = sum
		previous1 = previous2
		previous2 = line
	}
	return total
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 01')
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
