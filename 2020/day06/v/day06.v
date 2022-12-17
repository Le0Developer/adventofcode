module main

import os
import os.cmdline

fn solve_a(lines []string) int {
	mut solution := 0
	mut current := []rune{}
	for line in lines {
		if line == '' {
			solution += current.len
			current.clear()
		} else {
			for character in line {
				if character !in current {
					current << character
				}
			}
		}
	}
	if current.len > 0 {
		solution += current.len
	}
	return solution
}

fn solve_b(lines []string) int {
	mut solution := 0
	mut current := map[string]int{}
	mut people := 0
	for line in lines {
		if line == '' {
			for _, value in current {
				if value == people {
					solution++
				}
			}
			current = map[string]int{}
			people = 0
		} else {
			for character in line {
				str := character.str()
				if str !in current {
					current[str] = 0
				}
				current[str]++
			}
			people++
		}
	}
	if current.len > 0 {
		for _, value in current {
			if value == people {
				solution++
			}
		}
	}
	return solution
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) !
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(input)
	} else {
		solution = solve_a(input)
	}
	println('Solution is: $solution')
}
