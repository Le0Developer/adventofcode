module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut cwd := []string{}
	mut files := map[string]int{}
	mut dirs := []string{}
	for line in input_lines {
		parts := line.split(' ')
		if parts[0] == '$' {
			if parts[1] == 'cd' {
				if parts[2] == '/' {
					cwd.clear()
				} else if parts[2] == '..' {
					cwd.pop()
				} else {
					cwd << parts[2]
				}
			}
		} else { // must be ls results
			path := if cwd.len > 0 { cwd.join('/') + '/' + parts[1] } else { parts[1] }
			if parts[0] == 'dir' {
				dirs << path
			} else {
				files[path] = parts[0].int()
			}
		}
	}
	mut result := 0
	for directory in dirs {
		mut sum := 0
		for file, size in files {
			if file.starts_with(directory + '/') {
				sum += size
			}
		}
		if sum < 100000 {
			result += sum
		}
	}
	return result
}

fn challenge_b(input_lines []string) ?i64 {
	mut cwd := []string{}
	mut files := map[string]int{}
	mut dirs := []string{}
	for line in input_lines {
		parts := line.split(' ')
		if parts[0] == '$' {
			if parts[1] == 'cd' {
				if parts[2] == '/' {
					cwd.clear()
				} else if parts[2] == '..' {
					cwd.pop()
				} else {
					cwd << parts[2]
				}
			}
		} else { // must be ls results
			path := if cwd.len > 0 { cwd.join('/') + '/' + parts[1] } else { parts[1] }
			if parts[0] == 'dir' {
				dirs << path
			} else {
				files[path] = parts[0].int()
			}
		}
	}
	mut total := 0
	for _, size in files { total += size }
	to_free := 30000000 - 70000000 + total
	mut lowest := 1 << 31 - 1
	for directory in dirs {
		mut sum := 0
		for file, size in files {
			if file.starts_with(directory + '/') {
				sum += size
			}
		}
		if sum >= to_free && sum < lowest {
			lowest = sum
		}
	}
	return lowest
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2022 day 07')
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
