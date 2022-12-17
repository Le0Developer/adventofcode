module main

import math
import os
import os.cmdline

fn solve_a(input []string) int {
	mut facing := 1
	mut position := [0, 0]
	for line in input {
		direction := line[0]
		value := line[1..].int()
		match direction {
			`F` {
				match facing {
					0 { position[0] += value }
					1 { position[1] += value }
					2 { position[0] -= value }
					else { position[1] -= value }
				}
			}
			`L` {
				// Why doesn't V support -1 % 4 == 3 ?
				// horrible looking workaround, I know
				facing = ((facing - value / 90 - 4) % 4 + 4) % 4
			}
			`R` {
				facing = ((facing + value / 90 - 4) % 4 + 4) % 4
			}
			`N` {
				position[0] += value
			}
			`E` {
				position[1] += value
			}
			`S` {
				position[0] -= value
			}
			else {
				position[1] -= value
			}
		}
	}
	return int(math.abs(position[0])) + int(math.abs(position[1]))
}

fn solve_b(input []string) int {
	mut position := [0, 0]
	mut waypoint := [1, 10]
	for line in input {
		direction := line[0]
		value := line[1..].int()
		match direction {
			`F` {
				position[0] += waypoint[0] * value
				position[1] += waypoint[1] * value
			}
			`L` {
				for _ in 0 .. value / 90 {
					waypoint[1], waypoint[0] = -waypoint[0], waypoint[1]
				}
			}
			`R` {
				for _ in 0 .. value / 90 {
					waypoint[1], waypoint[0] = waypoint[0], -waypoint[1]
				}
			}
			`N` {
				waypoint[0] += value
			}
			`E` {
				waypoint[1] += value
			}
			`S` {
				waypoint[0] -= value
			}
			else {
				waypoint[1] -= value
			}
		}
	}
	return int(math.abs(position[0])) + int(math.abs(position[1]))
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
