module main

import os
import os.cmdline

fn solve_a(input []string) i64 {
	mut mem := []i64{len: 100000, init: 0}
	mut mask := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
	for line in input {
		parts := line.split(' ')
		if parts[0] == 'mask' {
			mask = parts[2]
		} else {
			index := parts[0].split('[')[1].split(']')[0].int()
			value := parts[2].i64()
			mut r := i64(0)
			for i in 0 .. 36 {
				mut toggled := value & (i64(1) << i) > 0
				if mask[35 - i] != `X` {
					toggled = mask[35 - i] == `1`
				}
				if toggled {
					r |= i64(1) << i
				}
			}
			mem[index] = r
		}
	}
	mut total := i64(0)
	for cell in mem {
		if cell > 0 {
			total += cell
		}
	}
	return total
}

fn recursive_memset(mask string, offset int, mut mem map[string]i64, value i64, index i64) {
	for i in offset .. mask.len {
		if mask[35 - i] == `X` {
			mem[index.str()] = value
			mem[(index | (i64(1) << i)).str()] = value
			recursive_memset(mask, i + 1, mut mem, value, index)
			recursive_memset(mask, i + 1, mut mem, value, index | (i64(1) << i))
			break
		}
	}
}

fn memset(mask string, mut mem map[string]i64, value i64, index i64) {
	recursive_memset(mask, 0, mut mem, value, index)
}

fn solve_b(input []string) i64 {
	mut mem := map[string]i64{}
	mut mask := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
	for line in input {
		parts := line.split(' ')
		if parts[0] == 'mask' {
			mask = parts[2]
		} else {
			index := parts[0].split('[')[1].split(']')[0].i64()
			value := parts[2].i64()
			mut r := i64(0)
			for i in 0 .. 36 {
				mut toggled := index & (i64(1) << i) > 0
				if mask[35 - i] == `X` {
					continue
				} else if mask[35 - i] == `1` {
					toggled = true
				}
				if toggled {
					r |= i64(1) << i
				}
			}
			memset(mask, mut mem, value, r)
		}
	}
	mut total := i64(0)
	for _, cell in mem {
		if cell > 0 {
			total += cell
		}
	}
	return total
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) !
	mut solution := i64(0)
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(input)
	} else {
		solution = solve_a(input)
	}
	println('Solution is: $solution')
}
