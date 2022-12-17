module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut total_gamma := 0
	mut total_epsilon := 0
	total := input_lines[0].len
	for i in 0 .. total {
		mut zeros := 0
		for line in input_lines {
			if line[i] == `0` {
				zeros++
			}
		}
		ones := input_lines.len - zeros
		if ones > zeros {
			total_gamma |= 1 << (total - i - 1)
		} else {
			total_epsilon |= 1 << (total - i - 1)
		}
	}
	return total_gamma * total_epsilon
}

fn challenge_b(input_lines []string) ?i64 {
	total := input_lines[0].len

	mut set := input_lines.clone()
	mut total_oxygen := 0
	for i in 0 .. total {
		mut zeros := 0
		for line in set {
			if line[i] == `0` {
				zeros++
			}
		}
		ones := set.len - zeros
		if ones >= zeros {
			set = set.filter(it[i] == `1`)
		} else {
			set = set.filter(it[i] == `0`)
		}

		if set.len == 1 {
			total_oxygen = '0b${set[0]}'.int()
			break
		}
	}

	set = input_lines.clone()
	mut total_co2 := 0
	for i in 0 .. total {
		mut zeros := 0
		for line in set {
			if line[i] == `0` {
				zeros++
			}
		}
		ones := set.len - zeros
		if ones < zeros {
			set = set.filter(it[i] == `1`)
		} else {
			set = set.filter(it[i] == `0`)
		}

		if set.len == 1 {
			total_co2 = '0b${set[0]}'.int()
			break
		}
	}
	return total_oxygen * total_co2
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 03')
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
