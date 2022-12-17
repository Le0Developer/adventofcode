module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	line := input_lines[0]
	for i in 0 .. line.len - 3 {
		c1 := line[i]
		c2 := line[i + 1]
		c3 := line[i + 2]
		c4 := line[i + 3]
		if c1 != c2 && c2 != c3 && c3 != c4 && c1 != c3 && c1 != c4 && c2 != c4 {
			return i + 4
		}
	}
	return -1
}

fn challenge_b(input_lines []string) ?i64 {
	line := input_lines[0]
	for i in 0 .. line.len - 14 {
		mut found_chars := map[int]bool{}
		mut found := true
		for j in i .. i + 14 {
			if line[j] in found_chars {
				found = false
				break
			}
			found_chars[line[j]] = true
		}
		if found {
			return i + 14
		}
	}
	return -1
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2022 day 06')
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
