module main

import os
import os.cmdline

const (
	tribonaci_sequence = [u64(1), 1, 2, 4, 7]
)

fn solve_a(mut values []int) int {
	mut diff_1 := 0
	mut diff_3 := 1
	mut value := 0
	for {
		if value + 1 in values {
			diff_1++
			value++
		} else if value + 2 in values {
			value += 2
		} else if value + 3 in values {
			diff_3++
			value += 3
		} else {
			return diff_1 * diff_3
		}
	}
	return -1
}

fn solve_b(mut values []int) u64 {
	mut streak := 0
	mut streaks := []int{}
	values << 0
	values.sort()
	for i, value in values[..values.len - 1] {
		diff := values[i + 1] - value
		match diff {
			1 {
				streak++
			}
			3 {
				streaks << streak
				streak = 0
			}
			else {}
		}
	}
	mut multr := u64(1)
	for mult in streaks {
		multr *= tribonaci_sequence[mult]
	}
	return multr
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file)!
	mut values := []int{}
	for x in input {
		values << x.int()
	}
	if '-b' in cmdline.only_options(os.args) {
		solution := solve_b(mut values)
		println('Solution is: ${solution}')
	} else {
		solution := solve_a(mut values)
		println('Solution is: ${solution}')
	}
}
