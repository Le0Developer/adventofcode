module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut mapped := map[string]int{}
	for line in input_lines {
		parts := line.split_any(' ,')
		if parts[0] == parts[3] { // vertical
			mut low := parts[1].int()
			mut high := parts[4].int()
			if low > high {
				low, high = high, low
			}
			for i in low .. high + 1 {
				mapped['${i}:${parts[0]}']++
			}
		} else if parts[1] == parts[4] { // horizontal
			mut low := parts[0].int()
			mut high := parts[3].int()
			if low > high {
				low, high = high, low
			}
			for i in low .. high + 1 {
				mapped['${parts[1]}:${i}']++
			}
		}
	}
	mut total := 0
	for _, value in mapped {
		if value > 1 {
			total++
		}
	}
	return total
}

fn challenge_b(input_lines []string) ?i64 {
	mut mapped := map[string]int{}
	for line in input_lines {
		parts := line.split_any(' ,')
		mut start_x := parts[0].int()
		mut start_y := parts[1].int()
		end_x := parts[3].int()
		end_y := parts[4].int()

		mut step_x := 0
		mut step_y := 0
		if start_x == end_x { // vertical
			step_y = if end_y > start_y { 1 } else { -1 }
		} else if start_y == end_y { // horizontal
			step_x = if end_x > start_x { 1 } else { -1 }
		} else { // diagonal
			step_x = if end_x > start_x { 1 } else { -1 }
			step_y = if end_y > start_y { 1 } else { -1 }
		}
		for start_x != end_x || start_y != end_y {
			mapped['${start_x}:${start_y}']++
			start_x += step_x
			start_y += step_y
		}
		mapped['${end_x}:${end_y}']++
	}
	mut total := 0
	for _, value in mapped {
		if value > 1 {
			total++
		}
	}
	return total
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 05')
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
