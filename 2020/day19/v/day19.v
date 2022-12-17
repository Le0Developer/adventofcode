module main

import pcre
import os
import os.cmdline

const (
	max_dept = 14
)

fn build_regex(rules map[string]string, ruleno string, dept int) string {
	rule := rules[ruleno]
	// println('$ruleno $rule')
	if rule[0] == `"` {
		return rune(rule[1]).str()
	}
	if dept >= max_dept {
		return '(c)'
	}
	mut out := ''
	mut is_pipe := false
	mut last := '0'
	mut count := 0
	for part in rule.split(' ') {
		if part == '|' {
			if count > 1 {
				out += '{${count}}'
			}
			out += '|'
			is_pipe = true
			count = 0
			last = '0'
		} else {
			if count > 1 && last != part {
				out += '{${count}}'
				count = 0
			}
			if last != part {
				out += build_regex(rules, part, dept + 1)
				last = part
				count = 0
			}
			count++
		}
	}
	if count > 1 {
		out += '{${count}}'
	}
	if !is_pipe {
		return out
	}
	return '(' + out + ')'
}

fn solve_a(input []string) int {
	mut total := -1
	mut rules := map[string]string{}
	mut to_test := []string{}
	for message in input {
		if total == -1 {
			if message == '' {
				total++
			} else {
				parts := message.split(': ')
				rules[parts[0]] = parts[1]
			}
		} else {
			to_test << message
		}
	}
	regex := '^' + build_regex(rules, '0', 0) + '$'
	println(regex)
	re := pcre.new_regex(regex, 0) or { panic(err) }
	for message in to_test {
		re.match_str(message, 0, 0) or { continue }
		total++
	}
	re.free()
	return total
}

fn solve_b(input []string) int {
	mut total := -1
	mut rules := map[string]string{}
	mut to_test := []string{}
	for message in input {
		if total == -1 {
			if message == '' {
				total++
			} else {
				parts := message.split(': ')
				rules[parts[0]] = parts[1]
			}
		} else {
			to_test << message
		}
	}
	rules['8'] = '42 | 42 8'
	rules['11'] = '42 31 | 42 11 31'
	regex := '^' + build_regex(rules, '0', 0) + '$'
	// println(regex)
	re := pcre.new_regex(regex, 0) or {
		if err.str() == 'Failed to compile regex' {
			println('PCRE cannot handle our regex, using python instead...')
			command := 'python -c "import re; r = re.compile(\'${regex}\'); print(len([x for x in ${to_test} if r.fullmatch(x)]))"'
			result := os.execute(command)
			return result.output.int()
		}
		panic(err)
	}
	for message in to_test {
		re.match_str(message, 0, 0) or { continue }
		total++
	}
	re.free()
	return total
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file)!
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(input)
	} else {
		solution = solve_a(input)
	}
	println('Solution is: ${solution}')
}
