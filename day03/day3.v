module main

import os
import os.cmdline

fn parse(lines []string) [][]bool {
	mut trees := [][]bool{}
	for i in 0 .. lines.len {
		line := lines[i]
		trees.push(line.bytes().map(it == `#`))
	}
	return trees
}

fn solve_a(trees [][]bool, dy int, dx int) int {
	mut x := 0
	mut y := 0
	mut encountered := 0
	for y < trees.len {
		if trees[y][x % trees[0].len] {
			encountered++
		}
		y += dy
		x += dx
	}
	return encountered
}

fn solve_b(trees [][]bool) int {
	return solve_a(trees, 1, 1) * solve_a(trees, 1, 3) * solve_a(trees, 1, 5) * solve_a(trees, 1, 7) *
		solve_a(trees, 2, 1)
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) ?
	trees := parse(input)
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(trees)
	} else {
		solution = solve_a(trees, 1, 3)
	}
	println('Solution is: $solution')
}
