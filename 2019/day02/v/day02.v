module main

import os
import os.cmdline

fn solve_a(input []string, noun int, verb int) int {
	mut mem := input[0].split(',').map(it.int())
	if noun >= 0 {
		mem[1] = noun
	}
	if verb >= 0 {
		mem[2] = verb
	}
	mut pointer := 0
	for {
		instr := mem[pointer]
		if instr == 1 {
			source1 := mem[pointer + 1]
			source2 := mem[pointer + 2]
			dest := mem[pointer + 3]
			mem[dest] = mem[source1] + mem[source2]
			pointer += 4
		} else if instr == 2 {
			source1 := mem[pointer + 1]
			source2 := mem[pointer + 2]
			dest := mem[pointer + 3]
			mem[dest] = mem[source1] * mem[source2]
			pointer += 4
		} else if instr == 99 {
			break
		}
	}
	return mem[0]
}

fn solve_b(input []string) int {
	for noun in 0 .. 99 {
		for verb in 0 .. 99 {
			result := solve_a(input, noun, verb)
			if result == 19690720 {
				return 100 * noun + verb
			}
		}
	}
	return -1
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) !
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(input)
	} else {
		solution = solve_a(input, 12, 2)
	}
	println('Solution is: $solution')
}
