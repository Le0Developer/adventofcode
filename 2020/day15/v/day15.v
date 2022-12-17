module main

import os
import os.cmdline

fn solve(input []string, until int) int {
	starting_set := input[0].split(',').map(it.int())
	mut numbers := []int{cap: until}
	for number in starting_set {
		numbers << number
	}
	for numbers.len < until {
		last_spoken := numbers[numbers.len - 1]
		mut spoken_before := -1
		for i in 1 .. numbers.len {
			cur := numbers[numbers.len - i - 1]
			if cur == last_spoken {
				spoken_before = numbers.len - i - 1
				break
			}
		}
		if spoken_before == -1 {
			numbers << 0
		} else {
			numbers << numbers.len - 1 - spoken_before
		}
	}
	return numbers[numbers.len - 1]
}

fn solve2(input []string, until int) int {
	// A more effiecient version of `solve`
	start := input[0].split(',')
	mut history := map[string][]int{}
	mut timestamp := 0
	mut last := start[start.len - 1].int()
	for value in start {
		history[value] = [timestamp]
		timestamp++
	}
	for timestamp < until {
		h := history[last.str()]
		if h.len < 2 {
			last = 0
		} else {
			delta := h[0] - h[1]
			last = delta
		}
		mut h2 := history[last.str()]
		h2.insert(0, timestamp)
		if h2.len > 2 {
			h2.pop()
		}
		history[last.str()] = h2
		timestamp++
	}
	return last
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file)!
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		// takes ~30 seconds with the challenge
		solution = solve2(input, 30000000)
	} else {
		solution = solve2(input, 2020)
	}
	println('Solution is: ${solution}')
}
