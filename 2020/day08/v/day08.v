module main

import os
import os.cmdline

struct Instruction {
	name  string
	value int
}

fn parse(lines []string) []Instruction {
	mut instructions := []Instruction{}
	for line in lines {
		parts := line.split(' ')
		instr := Instruction{parts[0], parts[1].int()}
		instructions << instr
	}
	return instructions
}

fn solve_a(instructions []Instruction) (bool, int) {
	mut acc := 0
	mut exec_pointer := 0
	mut visited := []int{}
	for {
		if exec_pointer in visited {
			return false, acc
		} else if exec_pointer >= instructions.len {
			return true, acc
		}
		visited << exec_pointer
		instr := instructions[exec_pointer]
		match instr.name {
			'nop' {
				exec_pointer++
			}
			'acc' {
				acc += instr.value
				exec_pointer++
			}
			'jmp' {
				exec_pointer = exec_pointer + instr.value
			}
			else {
				panic('panic')
			}
		}
	}
	return false, -1
}

fn solve_b(instructions_ []Instruction) (bool, int) {
	mut instructions := []Instruction{}
	for instr in instructions_ {
		instructions << instr
	}
	nop := Instruction{'nop', 0}
	for i in 0 .. instructions.len {
		instr := instructions[i]
		if instr.name != 'jmp' {
			continue
		}
		instructions[i] = nop
		ok, solution := solve_a(instructions)
		instructions[i] = instr
		if ok {
			return true, solution
		}
	}
	return false, -1
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) !
	instructions := parse(input)
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		_, solution = solve_b(instructions)
	} else {
		_, solution = solve_a(instructions)
	}
	println('Solution is: $solution')
}
