module main

import os
import os.cmdline

fn solve_a(entries []int) ?int {
	for value in entries {
		if 2020 - value in entries {
			return (2020 - value) * value
		}
	}
	return error('No solution found')
}

fn solve_b(entries []int) ?int {
	for i in 0 .. entries.len {
		value := entries[i]
		for k in (i + 1) .. entries.len {
			valuek := entries[k]
			if 2020 - value - valuek in entries {
				return (2020 - value - valuek) * value * valuek
			}
		}
	}
	return error('No solution found')
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file)!
	entries := input.map(it.int())
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(entries) or {
			println(err)
			return
		}
	} else {
		solution = solve_a(entries) or {
			println(err)
			return
		}
	}
	println('Solution is: ${solution}')
}
