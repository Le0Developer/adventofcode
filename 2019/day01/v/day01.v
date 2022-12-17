module main

import os
import os.cmdline

fn solve_a(input []string) int {
	mut total := 0
	for line in input {
		total += line.int() / 3 - 2
	}
	return total
}

fn solve_b(input []string) int {
	mut total := 0
	for line in input {
		mut fuel := line.int() / 3 - 2
		for fuel > 0 {
			total += fuel
			fuel = fuel / 3 - 2
		}
	}
	return total
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file)!
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(input)
	} else {
		solution = solve_a(input)
	}
	println('Solution is: ${solution}')
}
