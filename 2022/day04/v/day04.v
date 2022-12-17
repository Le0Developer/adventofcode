module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut overlaps := 0
	for line in input_lines {
		p1 := line.all_before(',')
		p2 := line.all_after(',')
		p1_min := p1.all_before('-').int()
		p1_max := p1.all_after('-').int()
		p2_min := p2.all_before('-').int()
		p2_max := p2.all_after('-').int()
		if (p2_max >= p1_max && p1_min >= p2_min) || (p1_max >= p2_max && p2_min >= p1_min) {
			overlaps++
		}
	}
	return overlaps
}

fn challenge_b(input_lines []string) ?i64 {
	mut overlaps := 0
	for line in input_lines {
		p1 := line.all_before(',')
		p2 := line.all_after(',')
		p1_min := p1.all_before('-').int()
		p1_max := p1.all_after('-').int()
		p2_min := p2.all_before('-').int()
		p2_max := p2.all_after('-').int()
		if (p2_min <= p1_max && p2_min >= p1_min) || (p1_min <= p2_max && p1_min >= p2_min) {
			overlaps++
		}
	}
	return overlaps
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2022 day 04')
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
