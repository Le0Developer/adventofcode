module main

import math
import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut visited_squares := map[string]bool{}
	mut head_x := 0
	mut head_y := 0
	mut tail_x := 0
	mut tail_y := 0
	for line in input_lines {
		direction := line[0]
		dx := match direction {
			`R` { 1 }
			`L` { -1 }
			else { 0 }
		}
		dy := match direction {
			`U` { 1 }
			`D` { -1 }
			else { 0 }
		}

		steps := line.all_after(' ').int()
		for _ in 0 .. steps {
			head_x += dx
			head_y += dy
			distance := math.abs(head_x - tail_x) + math.abs(head_y - tail_y)
			if distance >= 3 {
				tail_x = head_x - dx
				tail_y = head_y - dy
			} else if math.abs(head_x - tail_x) > 1 || math.abs(head_y - tail_y) > 1 {
				tail_x += dx
				tail_y += dy
			}
			visited_squares['$tail_x|$tail_y'] = true
		}
	}
	return visited_squares.values().len
}

fn challenge_b(input_lines []string) ?i64 {
	mut visited_squares := map[string]bool{}
	mut rope_x := []int{len: 10}
	mut rope_y := []int{len: 10}
	for line in input_lines {
		direction := line[0]
		dx := match direction {
			`R` { 1 }
			`L` { -1 }
			else { 0 }
		}
		dy := match direction {
			`U` { 1 }
			`D` { -1 }
			else { 0 }
		}

		steps := line.all_after(' ').int()
		for _ in 0 .. steps {
			rope_x[0] += dx
			rope_y[0] += dy
			for i in 1 .. 10 {
				if math.abs(rope_x[i] - rope_x[i - 1]) > 1 || math.abs(rope_y[i] - rope_y[i - 1]) > 1 {
					mut lowest_distance := 1 << 31 - 1
					mut lx := 0
					mut ly := 0
					for ddx in -1 .. 2 {
						for ddy in -1 .. 2 {
							d := math.abs(rope_x[i] + ddx - rope_x[i - 1]) + math.abs(rope_y[i] + ddy - rope_y[i - 1])
							if lowest_distance > d {
								lowest_distance = d
								lx = rope_x[i] + ddx
								ly = rope_y[i] + ddy
							}
						}
					}
					rope_x[i] = lx
					rope_y[i] = ly
				}
			}
			visited_squares['${rope_x[9]}|${rope_y[9]}'] = true
		}
	}
	return visited_squares.values().len
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2022 day 09')
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
