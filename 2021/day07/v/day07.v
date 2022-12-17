module main

import arrays
import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	input := input_lines[0].split(',').map(it.int())
	// I love arrays <3
	low := arrays.min(input)?
	high := arrays.max(input)?
	mut lowest_cost := (1 << 31) - 1
	for i in low .. (high + 1) {
		mut cost := 0
		for value in input {
			mut steps := value - i
			if steps < 0 { // math.abs takes f64....
				steps = -steps
			}
			cost += steps
		}
		if cost < lowest_cost {
			lowest_cost = cost
		}
	}
	return lowest_cost
}

fn challenge_b(input_lines []string) ?i64 {
	input := input_lines[0].split(',').map(it.int())
	// I love arrays <3
	low := arrays.min(input)?
	high := arrays.max(input)?
	mut lowest_cost := (1 << 31) - 1

	mut cost_table := [4096]int{}
	for i in 1 .. 4096 {
		cost_table[i] = cost_table[i - 1] + i
	}

	for i in low .. (high + 1) {
		mut cost := 0
		for value in input {
			mut steps := value - i
			if steps < 0 { // math.abs takes f64....
				steps = -steps
			}
			cost += cost_table[steps]
		}
		if cost < lowest_cost {
			lowest_cost = cost
		}
	}
	return lowest_cost
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 07')
	fp.version('v0.1.0')
	fp.skip_executable()
	fp.limit_free_args_to_exactly(1)?
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
