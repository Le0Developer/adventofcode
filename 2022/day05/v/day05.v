module main

import flag
import os

fn challenge_a(input_lines []string) ?string {
	mut stacks := [][]string{}
	mut initial_stacking := true
	for line in input_lines {
		if line == '' {
			initial_stacking = false
		} else if initial_stacking {
			for i := 1; i < line.len; i += 4 {
				idx := (i - 1) / 4
				for idx >= stacks.len {
					stacks << []string{}
				}
				if line[i] != ` ` && line[i] > 0x40 {
					stacks[idx].insert(0, line[i].ascii_str())
				}
			}
		} else {
			instructions := line.split(' ')
			amount := instructions[1].int()
			source := instructions[3].int()
			destination := instructions[5].int()

			for _ in 0 .. amount {
				stacks[destination - 1] << stacks[source - 1].pop()
			}
		}
	}
	mut res := ''
	for stack in stacks {
		res += stack.last()
	}
	return res
}

fn challenge_b(input_lines []string) ?string {
	mut stacks := [][]string{}
	mut initial_stacking := true
	for line in input_lines {
		if line == '' {
			initial_stacking = false
		} else if initial_stacking {
			for i := 1; i < line.len; i += 4 {
				idx := (i - 1) / 4
				for idx >= stacks.len {
					stacks << []string{}
				}
				if line[i] != ` ` && line[i] > 0x40 {
					stacks[idx].insert(0, line[i].ascii_str())
				}
			}
		} else {
			instructions := line.split(' ')
			amount := instructions[1].int()
			source := instructions[3].int()
			destination := instructions[5].int()

			current := stacks[destination - 1].len
			for _ in 0 .. amount {
				stacks[destination - 1].insert(current, stacks[source - 1].pop())
			}
		}
	}
	mut res := ''
	for stack in stacks {
		res += stack.last()
	}
	return res
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2022 day 05')
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
