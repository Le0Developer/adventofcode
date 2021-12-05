module main

import os
import os.cmdline

fn solve_a(input []string) int {
	timestamp := input[0].int()
	ids := input[1].split(',').filter(it != 'x').map(it.int())
	mut diff := ids.map([it - timestamp % it, it])
	mut lowest := [2147483647, -1]
	for entry in diff {
		if entry[0] < lowest[0] {
			lowest = entry.clone()
		}
	}
	return lowest[0] * lowest[1]
}

fn solve_b(input []string) i64 {
	mut ids := input[1].split(',').map(fn (w string) string {
		if w == 'x' { return '-1'
		 } else { return w
		 }
	}).map(i64(it.int()))
	mut timestamp := i64(0)
	mut record := i64(0)
	mut increment := ids[0]
	mut last := i64(0)
	for timestamp >= 0 {
		timestamp += increment
		mut valid := true
		for minute, id in ids {
			if id < 0 {
				continue
			}
			if (timestamp + minute) % id > 0 {
				valid = false
				if minute >= record {
					increment = timestamp - last
					record = minute
					last = timestamp
				}
				break
			}
		}
		if valid {
			return timestamp
		}
	}
	return -1
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) ?
	if '-b' in cmdline.only_options(os.args) {
		solution := solve_b(input)
		println('Solution is: $solution')
	} else {
		solution := solve_a(input)
		println('Solution is: $solution')
	}
}
