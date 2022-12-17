module main

import flag
import os

fn solve_challenge(cycles int, input []int) u64 {
	mut states := [7]u64{}
	mut pending := [2]u64{}
	for val in input {
		states[val]++
	}
	for cycle in 0 .. cycles {
		current := states[cycle % 7]
		states[cycle % 7] += pending[cycle % 2]
		pending[cycle % 2] = current
	}
	states[cycles % 7] += pending[cycles % 2]
	states[(cycles + 1) % 7] += pending[(cycles + 1) % 2]
	mut sum := u64(0)
	for s in states {
		sum += s
	}
	return sum
}

fn challenge_a(input_lines []string) ?u64 {
	return solve_challenge(80, input_lines[0].split(',').map(it.int()))
}

fn challenge_b(input_lines []string) ?u64 {
	return solve_challenge(256, input_lines[0].split(',').map(it.int()))
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 06')
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
	input_lines := os.read_lines(input_filename) !
	solution := if !is_b { challenge_a(input_lines) ? } else { challenge_b(input_lines) ? }
	println('Solution is $solution')
}
