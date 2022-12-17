module main

import math
import os
import os.cmdline

fn solve_a(input []string) int {
	mut room := map[string]bool{}
	mut pos_x := 0
	mut pos_y := 0
	for wire_instruction in input[0].split(',') {
		value := wire_instruction[1..].int()
		if wire_instruction[0] == `R` {
			for _ in 0 .. value {
				pos_x++
				room['${pos_y}:${pos_x}'] = true
			}
		} else if wire_instruction[0] == `L` {
			for _ in 0 .. value {
				pos_x--
				room['${pos_y}:${pos_x}'] = true
			}
		} else if wire_instruction[0] == `U` {
			for _ in 0 .. value {
				pos_y++
				room['${pos_y}:${pos_x}'] = true
			}
		} else if wire_instruction[0] == `D` {
			for _ in 0 .. value {
				pos_y--
				room['${pos_y}:${pos_x}'] = true
			}
		}
	}
	pos_x = 0
	pos_y = 0
	mut closests := (1 << 31) - 1
	for wire_instruction in input[1].split(',') {
		value := wire_instruction[1..].int()
		if wire_instruction[0] == `R` {
			for _ in 0 .. value {
				pos_x++
				if room['${pos_y}:${pos_x}'] {
					distance := int(math.abs(pos_y)) + int(math.abs(pos_x))
					if distance < closests {
						closests = distance
					}
				}
			}
		} else if wire_instruction[0] == `L` {
			for _ in 0 .. value {
				pos_x--
				if room['${pos_y}:${pos_x}'] {
					distance := int(math.abs(pos_y)) + int(math.abs(pos_x))
					if distance < closests {
						closests = distance
					}
				}
			}
		} else if wire_instruction[0] == `U` {
			for _ in 0 .. value {
				pos_y++
				if room['${pos_y}:${pos_x}'] {
					distance := int(math.abs(pos_y)) + int(math.abs(pos_x))
					if distance < closests {
						closests = distance
					}
				}
			}
		} else if wire_instruction[0] == `D` {
			for _ in 0 .. value {
				pos_y--
				if room['${pos_y}:${pos_x}'] {
					distance := int(math.abs(pos_y)) + int(math.abs(pos_x))
					if distance < closests {
						closests = distance
					}
				}
			}
		}
	}
	return closests
}

fn solve_b(input []string) int {
	mut room := map[string]bool{}
	mut stepmap := map[string]int{}
	mut pos_x := 0
	mut pos_y := 0
	mut steps := 0
	for wire_instruction in input[0].split(',') {
		value := wire_instruction[1..].int()
		if wire_instruction[0] == `R` {
			for _ in 0 .. value {
				pos_x++
				steps++
				if !room['${pos_y}:${pos_x}'] {
					stepmap['${pos_y}:${pos_x}'] = steps
				}
				room['${pos_y}:${pos_x}'] = true
			}
		} else if wire_instruction[0] == `L` {
			for _ in 0 .. value {
				pos_x--
				steps++
				if !room['${pos_y}:${pos_x}'] {
					stepmap['${pos_y}:${pos_x}'] = steps
				}
				room['${pos_y}:${pos_x}'] = true
			}
		} else if wire_instruction[0] == `U` {
			for _ in 0 .. value {
				pos_y++
				steps++
				if !room['${pos_y}:${pos_x}'] {
					stepmap['${pos_y}:${pos_x}'] = steps
				}
				room['${pos_y}:${pos_x}'] = true
			}
		} else if wire_instruction[0] == `D` {
			for _ in 0 .. value {
				pos_y--
				steps++
				if !room['${pos_y}:${pos_x}'] {
					stepmap['${pos_y}:${pos_x}'] = steps
				}
				room['${pos_y}:${pos_x}'] = true
			}
		}
	}
	pos_x = 0
	pos_y = 0
	steps = 0
	mut closests := (1 << 31) - 1
	for wire_instruction in input[1].split(',') {
		value := wire_instruction[1..].int()
		if wire_instruction[0] == `R` {
			for _ in 0 .. value {
				pos_x++
				steps++
				if room['${pos_y}:${pos_x}'] {
					distance := steps + stepmap['${pos_y}:${pos_x}']
					if distance < closests {
						closests = distance
					}
				}
			}
		} else if wire_instruction[0] == `L` {
			for _ in 0 .. value {
				pos_x--
				steps++
				if room['${pos_y}:${pos_x}'] {
					distance := steps + stepmap['${pos_y}:${pos_x}']
					if distance < closests {
						closests = distance
					}
				}
			}
		} else if wire_instruction[0] == `U` {
			for _ in 0 .. value {
				pos_y++
				steps++
				if room['${pos_y}:${pos_x}'] {
					distance := steps + stepmap['${pos_y}:${pos_x}']
					if distance < closests {
						closests = distance
					}
				}
			}
		} else if wire_instruction[0] == `D` {
			for _ in 0 .. value {
				pos_y--
				steps++
				if room['${pos_y}:${pos_x}'] {
					distance := steps + stepmap['${pos_y}:${pos_x}']
					if distance < closests {
						closests = distance
					}
				}
			}
		}
	}
	return closests
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
