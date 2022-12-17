module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut priority := 0
	for line in input_lines {
		h1 := line[..line.len / 2]
		h2 := line[line.len / 2..]
		for character in h2 {
			if h1.contains(character.ascii_str()) {
				if character <= `Z` {
					priority += character - 0x26
				} else {
					priority += character - 0x60
				}
				break
			}
		}
	}
	return priority
}

fn challenge_b(input_lines []string) ?i64 {
	mut badges := 0
	for group := 0; group < input_lines.len; group += 3 {
		l1 := input_lines[group]
		l2 := input_lines[group + 1]
		l3 := input_lines[group + 2]
		for character in l1 {
			if l2.contains(character.ascii_str()) && l3.contains(character.ascii_str()) {
				if character <= `Z` {
					badges += character - 0x26
				} else {
					badges += character - 0x60
				}
				break
			}
		}
	}
	return badges
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2022 day 03')
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
