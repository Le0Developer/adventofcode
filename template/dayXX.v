module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	// code here
	return -1
}

fn challenge_b(input_lines []string) ?i64 {
	// code here
	return -1
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 202_ day __')
	fp.version('v0.1.0')
	fp.limit_free_args_to_exactly(1) ?
	is_b := fp.bool('b', `b`, false, 'b challenge')
	// more options here
	additional_args := fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}
	input_filename := additional_args[0]
	input_lines := os.read_lines(input_filename) ?
	solution := if !is_b { challenge_a(input_lines) ? } else { challenge_b(input_lines) ? }
	println('Solution is $solution')
}
