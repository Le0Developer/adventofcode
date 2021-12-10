module main

import flag
import os

const (
	character_groups = {
		`(`: `)`
		`[`: `]`
		`{`: `}`
		`<`: `>`
	}
	points_a = {
		`)`: 3
		`]`: 57
		`}`: 1197
		`>`: 25137
	}
	points_b = {
		`)`: 1
		`]`: 2
		`}`: 3
		`>`: 4
	}
)

fn challenge_a(input_lines []string) ?i64 {
	mut total := 0
	for line in input_lines {
		mut stack := []byte{}
		for char in line {
			if char in character_groups {
				stack << character_groups[char]
			} else if char == stack.last() {
				stack.delete_last()
			} else {
				// println('illegal $char, expected ${stack.last()}')
				total += points_a[char]
				break
			}
		}
	}
	return total
}

fn challenge_b(input_lines []string) ?i64 {
	mut total := []i64{}
	for line in input_lines {
		mut stack := []byte{}
		mut corrupted := false
		for char in line {
			if char in character_groups {
				stack << character_groups[char]
			} else if char == stack.last() {
				stack.delete_last()
			} else {
				corrupted = true
				break
			}
		}
		if corrupted {
			continue
		}
		mut subtotal := i64(0)
		for stack.len > 0 {
			subtotal = subtotal * 5 + points_b[stack.pop()]
		}
		total << subtotal
	}
	total.sort()
	return total[total.len / 2]
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 10')
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
