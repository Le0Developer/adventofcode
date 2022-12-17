module main

import arrays
import flag
import os

fn do_the_thing(input_lines []string, max_folds int, display_last bool) ?i64 {
	mut raw_dots := []string{}
	mut fast_raw_dots := map[string]bool{}
	mut instructions := []string{}
	for line in input_lines {
		if line.starts_with('fold along ') {
			instructions << line.split(' ').last()
		} else if line.len > 0 {
			raw_dots << line
			fast_raw_dots[line] = true
		}
	}
	max_x := 1 + arrays.max(raw_dots.map(it.split(',')[0].int()))?
	max_y := 1 + arrays.max(raw_dots.map(it.split(',')[1].int()))?
	mut dots := [][]bool{len: max_y, init: []bool{cap: max_x}}
	for y in 0 .. max_y {
		for x in 0 .. max_x {
			dots[y] << '${x},${y}' in fast_raw_dots // ~10 times faster than raw_dots
			// print(if row.last() { '#' } else { '.' })
		}
		// println('')
	}
	for i, instruction in instructions {
		if i >= max_folds {
			break
		}
		value := instruction.split('=')[1].int()
		if instruction[0] == `y` {
			dot_len := dots.len
			for y in value .. dot_len {
				for x, is_dot in dots[value] {
					if is_dot {
						dots[value + value - y][x] = true
					}
				}
				dots.delete(value)
			}
		} else {
			dot_len := dots[0].len
			for x in value .. dot_len {
				for y in 0 .. dots.len {
					if dots[y][value] {
						dots[y][value + value - x] = true
					}
					dots[y].delete(value)
				}
			}
		}
	}
	if display_last {
		for y in dots {
			for x in y {
				print(if x { '#' } else { ' ' })
			}
			println('')
		}
		println('')
	}
	return i64(arrays.sum(dots.map(arrays.sum(it.map(int(it)))?))?)
}

fn challenge_a(input_lines []string) ?i64 {
	return do_the_thing(input_lines, 1, false)
}

fn challenge_b(input_lines []string) ?i64 {
	return do_the_thing(input_lines, 100, true)
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 13')
	fp.version('v0.1.0')
	fp.skip_executable()
	fp.limit_free_args_to_exactly(1)!
	is_b := fp.bool('b', `b`, false, 'b challenge')
	// more options here
	additional_args := fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}
	input_filename := additional_args[0]
	input_lines := os.read_lines(input_filename)!
	solution := if !is_b { challenge_a(input_lines)? } else { challenge_b(input_lines)? }
	println('Solution is ${solution}')
}
