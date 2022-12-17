module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut highest := 0
	mut current := 0
	for line in input_lines {
		if line == '' {
			if current > highest {
				highest = current
			}
			current = 0
		} else {
			current += line.int()
		}
	}
	return highest
}

fn challenge_b(input_lines []string) ?i64 {
	mut current := 0
	mut snacks := []int{}
	for line in input_lines {
		if line == '' {
			snacks << current
			current = 0
		} else {
			current += line.int()
		}
	}
	snacks.sort(a > b)
	return snacks[0] + snacks[1] + snacks[2]
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2022 day 01')
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
