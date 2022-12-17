module main

import os
import os.cmdline

fn parse(line string) []i64 {
	mut result := []i64{}
	for character in line {
		if character != ` ` {
			if character >= 0x30 && character <= 0x39 {
				result << i64(character - 0x30)
			} else {
				result << -i64(character)
			}
		}
	}
	return result
}

fn eval_a(calc_ []i64) i64 {
	mut calc := calc_.clone()
	for calc.len > 1 {
		// println(calc)
		mut deepest := 0
		mut pos := 0
		mut dept := 0
		for index, b in calc {
			if -b == `(` {
				dept++
				if dept > deepest {
					deepest = dept
					pos = index + 1
				}
			} else if -b == `)` {
				dept--
			}
		}
		if -calc[pos + 1] == `)` {
			// empty parentheses with only value
			// e.g: (123)
			value := calc[pos]
			to_the_right := calc[pos + 2..].clone()
			calc = calc[..pos - 1]
			calc << value
			calc << to_the_right
		} else {
			left := calc[pos]
			op := calc[pos + 1]
			right := calc[pos + 2]
			mut r := i64(0)
			if -op == `+` {
				r = left + right
			} else {
				r = left * right
			}
			// println('$left ? $right = $r (at $pos)')
			if pos >= 0 {
				to_the_right := calc[pos + 3..].clone()
				calc = calc[..pos]
				calc << r
				calc << to_the_right
			} else {
				to_the_right := calc[pos + 3..].clone()
				calc = []i64{}
				calc << r
				calc << to_the_right
			}
		}
	}
	// println(calc)
	return calc[0]
}

fn eval_b(calc_ []i64) i64 {
	mut calc := calc_.clone()
	for calc.len > 1 {
		// println(calc)
		mut deepest := 0
		mut pos := 0
		mut dept := 0
		for index, b in calc {
			if -b == `(` {
				dept++
				if dept * 2 > deepest {
					deepest = dept * 2
					pos = index + 1
				}
			} else if -b == `)` {
				dept--
			} else if -b == `+` {
				if dept * 2 >= deepest {
					deepest = dept * 2 + 1
					pos = index - 1
				}
			}
		}
		if pos > 0 && -calc[pos + 1] == `)` && deepest % 2 == 0 {
			// empty parentheses with only value
			// e.g: (123)
			value := calc[pos]
			to_the_right := calc[pos + 2..].clone()
			calc = calc[..pos - 1]
			calc << value
			calc << to_the_right
		} else {
			left := calc[pos]
			op := calc[pos + 1]
			right := calc[pos + 2]
			mut r := i64(0)
			if -op == `+` {
				r = left + right
			} else {
				r = left * right
			}
			// println('$left ? $right = $r (at $pos)')
			if pos >= 0 {
				to_the_right := calc[pos + 3..].clone()
				calc = calc[..pos]
				calc << r
				calc << to_the_right
			} else {
				to_the_right := calc[pos + 3..].clone()
				calc = []i64{}
				calc << r
				calc << to_the_right
			}
		}
	}
	// println(calc)
	return calc[0]
}

fn solve_a(input []string) i64 {
	mut sum := i64(0)
	for line in input {
		// println(line)
		calc := parse(line)
		sum += eval_a(calc)
	}
	return sum
}

fn solve_b(input []string) i64 {
	mut sum := i64(0)
	for line in input {
		// println(line)
		calc := parse(line)
		sum += eval_b(calc)
	}
	return sum
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file)!
	mut solution := i64(0)
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(input)
	} else {
		solution = solve_a(input)
	}
	println('Solution is: ${solution}')
}
