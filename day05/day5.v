module main

import os
import os.cmdline

fn parse(lines []string) [][][]bool {
	mut passes := [][][]bool{}
	for line in lines {
		mut pass := [][]bool{len: 2, init: []bool{}}
		for char in line {
			match char {
				`F`, `B` { pass[0] << char == `B` }
				`R`, `L` { pass[1] << char == `R` }
				else { panic('invalid input') }
			}
		}
		passes.push(pass)
	}
	return passes
}

fn resolve(part []bool, limit int) int {
	mut lower_bound := 0
	mut upper_bound := limit
	for i in 0 .. part.len {
		if part[i] {
			lower_bound += (upper_bound - lower_bound) / 2
		} else {
			upper_bound -= (upper_bound - lower_bound) / 2
		}
	}
	return lower_bound
}

fn solve_a(passes [][][]bool) int {
	mut highest := 0
	for pass in passes {
		row := resolve(pass[0], 128)
		column := resolve(pass[1], 8)
		id := row * 8 + column
		if id > highest {
			highest = id
		}
	}
	return highest
}

fn solve_b(passes [][][]bool) int {
	mut seats := []int{}
	for pass in passes {
		row := resolve(pass[0], 128)
		column := resolve(pass[1], 8)
		id := row * 8 + column
		seats << id
	}
	seats.sort()
	for i in 0 .. seats[seats.len - 1] {
		if i !in seats && i - 1 in seats && i + 1 in seats {
			return i
		}
	}
	return -1
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) ?
	passes := parse(input)
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(passes)
	} else {
		solution = solve_a(passes)
	}
	println('Solution is: $solution')
}
