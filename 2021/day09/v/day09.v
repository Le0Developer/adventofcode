module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut total := 0
	for i, line in input_lines {
		for j, value in line.split('') {
			current := value.int()
			left := if j > 0 { line[j - 1] - 0x30 } else { 10 }
			right := if j + 1 < line.len { line[j + 1] - 0x30 } else { 10 }
			top := if i > 0 { input_lines[i - 1][j] - 0x30 } else { 10 }
			bottom := if i + 1 < input_lines.len { input_lines[i + 1][j] - 0x30 } else { 10 }
			if left > current && right > current && top > current && bottom > current {
				total += current + 1
			}
		}
	}
	return total
}

fn challenge_b(input_lines []string) ?i64 {
	mut basins := []int{}
	for i, line in input_lines {
		for j, value in line.split('') {
			current := value.int()
			left := if j > 0 { line[j - 1] - 0x30 } else { 10 }
			right := if j + 1 < line.len { line[j + 1] - 0x30 } else { 10 }
			top := if i > 0 { input_lines[i - 1][j] - 0x30 } else { 10 }
			bottom := if i + 1 < input_lines.len { input_lines[i + 1][j] - 0x30 } else { 10 }
			if left > current && right > current && top > current && bottom > current {
				mut current_basins := map[string]bool{}
				find_basins(input_lines, j, i, mut current_basins)
				basins << current_basins.len + 1
			}
		}
	}
	basins.sort(a > b)
	return i64(basins[0]) * basins[1] * basins[2]
}

fn find_basins(input_lines []string, x int, y int, mut basins map[string]bool) {
	current := input_lines[y][x] - 0x30
	left := if x > 0 { input_lines[y][x - 1] - 0x30 } else { 10 }
	right := if x + 1 < input_lines[y].len { input_lines[y][x + 1] - 0x30 } else { 10 }
	top := if y > 0 { input_lines[y - 1][x] - 0x30 } else { 10 }
	bottom := if y + 1 < input_lines.len { input_lines[y + 1][x] - 0x30 } else { 10 }

	if left > current && left < 9 && '$y:${x - 1}' !in basins {
		basins['$y:${x - 1}'] = true
		find_basins(input_lines, x - 1, y, mut basins)
	}
	if right > current && right < 9 && '$y:${x + 1}' !in basins {
		basins['$y:${x + 1}'] = true
		find_basins(input_lines, x + 1, y, mut basins)
	}
	if top > current && top < 9 && '${y - 1}:$x' !in basins {
		basins['${y - 1}:$x'] = true
		find_basins(input_lines, x, y - 1, mut basins)
	}
	if bottom > current && bottom < 9 && '${y + 1}:$x' !in basins {
		basins['${y + 1}:$x'] = true
		find_basins(input_lines, x, y + 1, mut basins)
	}
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 09')
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
