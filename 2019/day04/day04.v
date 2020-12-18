module main

import os
import os.cmdline

fn solve_a(input []string) int {
	lower_bounds := input[0].split('-')[0].int()
	upper_bound := input[0].split('-')[1].int()
	mut total := 0
	for i in lower_bounds .. upper_bound {
		s := i.str()
		mut valid := true
		mut two_in_a_row := false
		for j in 1 .. 6 {
			if s[j] < s[j - 1] {
				valid = false
				break
			} else if s[j] == s[j - 1] {
				two_in_a_row = true
			}
		}
		if valid && two_in_a_row {
			total++
		}
	}
	return total
}

fn solve_b(input []string) int {
	lower_bounds := input[0].split('-')[0].int()
	upper_bound := input[0].split('-')[1].int()
	mut total := 0
	for i in lower_bounds .. upper_bound {
		s := i.str()
		mut valid := true
		mut char := -1
		mut two_in_a_row := false
		for j in 1 .. 6 {
			if s[j] < s[j - 1] {
				valid = false
				break
			} else if s[j] == s[j - 1] && char != s[j] && !two_in_a_row {
				two_in_a_row = true
				char = s[j]
			} else if s[j] == s[j - 1] && char == s[j] {
				two_in_a_row = false
			}
		}
		if valid && two_in_a_row {
			total++
		}
	}
	return total
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) ?
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(input)
	} else {
		solution = solve_a(input)
	}
	println('Solution is: $solution')
}
