module main

import os
import os.cmdline

fn solve_a(values []int, preamble int) int {
	for i in preamble .. values.len {
		value := values[i]
		preamblep := values[i - preamble..i]
		mut found := false
		for valuep in preamblep {
			if value - valuep in preamblep && value - valuep != valuep {
				found = true
				break
			}
		}
		if !found {
			return value
		}
	}
	return -1
}

fn solve_b(values []int, preamble int) int {
	invalid_number := solve_a(values, preamble)
	for i in 0 .. values.len {
		mut sum := values[i]
		for k in 1 + i .. values.len {
			sum += values[k]
			if sum > invalid_number {
				break
			} else if sum == invalid_number {
				mut range := values[i..1 + k]
				range.sort()
				return range[0] + range[range.len - 1]
			}
		}
	}
	return -1
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) !
	mut values := []int{}
	for x in input {
		values << x.int()
	}
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(values, 5) // use 25 for real challenge
	} else {
		solution = solve_a(values, 5) // use 25 for real challenge
	}
	println('Solution is: $solution')
}
