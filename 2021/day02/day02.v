module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut dept := 0
	mut position := 0
	for line in input_lines {
		parts := line.split(' ')
		match parts[0] {
			'forward' {
				position += parts[1].int()
			}
			'down' {
				dept += parts[1].int()
			}
			'up' {
				dept -= parts[1].int()
			}
			else { panic('unexpected instruction: $line') }
		}
	}
	return position * dept
}

fn challenge_b(input_lines []string) ?i64 {
	mut dept := 0
	mut position := 0
	mut aim := 0
	for line in input_lines {
		parts := line.split(' ')
		match parts[0] {
			'forward' {
				position += parts[1].int()
				dept += parts[1].int() * aim
			}
			'down' {
				aim += parts[1].int()
			}
			'up' {
				aim -= parts[1].int()
			}
			else { panic('unexpected instruction: $line') }
		}
	}
	return position * dept
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 02')
	fp.version('v0.1.0')
	fp.skip_executable()
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
