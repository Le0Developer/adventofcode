import os
import os.cmdline

const (
	search = 'shiny gold'
)

fn parse(lines []string) map[string]map[string]int {
	mut bags := map[string]map[string]int{}
	for line in lines {
		contain_split := line.split(' bags contain ')
		name := contain_split[0]
		contains := contain_split[1]
		containparts := contains[..contains.len - 1].split(', ')
		mut fields := map[string]int{}
		if contains != 'no other bags.' {
			for containsbag in containparts {
				parts := containsbag.split(' ')
				fields[parts[1..parts.len - 1].join(' ')] = parts[0].int()
			}
		}
		bags[name] = fields
	}
	return bags
}

fn solve_a(bags map[string]map[string]int) int {
	mut processor := map[string]bool{}
	processor[search] = true
	mut done := false
	for !done {
		done = true
		for name, mapping in bags {
			if name !in processor {
				for name2, _ in mapping {
					if name2 in processor {
						processor[name] = true
						done = false
					}
				}
			}
		}
	}
	return processor.len - 1
}

fn solve_b(bags map[string]map[string]int) int {
	mut processor := map[string]int{}
	mut done := false
	for !done {
		done = true
		for name, mapping in bags {
			if mapping.len == 0 && name !in processor {
				processor[name] = 1
				done = false
			}
			mut value := 1
			for name2, multiplier in mapping {
				if name2 !in processor {
					value = -1
					break
				}
				value += multiplier * processor[name2]
			}
			if value > 1 && (name !in processor || processor[name] > value) {
				processor[name] = value
				done = false
			}
		}
	}
	return processor[search] - 1
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) ?
	bags := parse(input)
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(bags)
	} else {
		solution = solve_a(bags)
	}
	println('Solution is: $solution')
}
