module main

import os
import os.cmdline

struct Policy {
	value_0  int // X-y z: abcdef
	value_1  int // x-Y z: abcdef
	char     rune // x-y Z: abcdef
	password string // x-y z: ABCDEF
}

fn (p Policy) valid_a() bool {
	occurences := p.password.bytes().filter(it == p.char).len
	return p.value_0 <= occurences && occurences <= p.value_1
}

fn (p Policy) valid_b() bool {
	return (p.password[p.value_0 - 1] == p.char &&
		p.password[p.value_1 - 1] != p.char) ||
		(p.password[p.value_0 - 1] != p.char && p.password[p.value_1 - 1] == p.char)
}

fn parse(lines []string) []Policy {
	mut policies := []Policy{}
	for policy in lines {
		parts := policy.split(' ')
		value_part := parts[0]
		char := parts[1][0]
		password := parts[2]
		value_parts := value_part.split('-')
		value_0 := value_parts[0].int()
		value_1 := value_parts[1].int()
		policies.push(Policy{value_0, value_1, char, password})
	}
	return policies
}

fn solve_a(policies []Policy) int {
	mut valid := 0
	for policy in policies {
		if policy.valid_a() {
			valid++
		}
	}
	return valid
}

fn solve_b(policies []Policy) int {
	mut valid := 0
	for policy in policies {
		if policy.valid_b() {
			valid++
		}
	}
	return valid
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) ?
	policies := parse(input)
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(policies)
	} else {
		solution = solve_a(policies)
	}
	println('Solution is: $solution')
}
