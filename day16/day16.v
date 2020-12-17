module main

import os
import os.cmdline

struct Field {
	name        string
	range_1_min int
	range_1_max int
	range_2_min int
	range_2_max int
mut:
	matching    []int
	matched     bool
}

fn solve_a(input []string) int {
	mut ranges := [][]int{}
	mut invalid := 0
	mut state := 0
	for line in input {
		if line == 'your ticket:' {
			state = 1
			continue
		} else if line == 'nearby tickets:' {
			state = 2
			continue
		} else if line == '' {
			continue
		}
		if state == 0 {
			parts := line.split(': ')[1].split(' ')
			range_1 := parts[0].split('-')
			range_2 := parts[2].split('-')
			ranges << [range_1[0].int(), range_1[1].int()]
			ranges << [range_2[0].int(), range_2[1].int()]
		} else if state == 2 {
			fields := line.split(',').map(it.int())
			for field in fields {
				mut is_valid := false
				for range in ranges {
					if field >= range[0] && field <= range[1] {
						is_valid = true
						break
					}
				}
				if !is_valid {
					invalid += field
				}
			}
		}
	}
	return invalid
}

fn solve_b(input []string) i64 {
	mut fields := []Field{}
	mut valid_tickets := [][]int{}
	mut myticket := []int{}
	mut state := 0
	for line in input {
		if line == 'your ticket:' {
			state = 1
			continue
		} else if line == 'nearby tickets:' {
			state = 2
			continue
		} else if line == '' {
			continue
		}
		if state == 0 {
			parts := line.split(': ')[1].split(' ')
			range_1 := parts[0].split('-')
			range_2 := parts[2].split('-')
			fields <<
				Field{line.split(': ')[0], range_1[0].int(), range_1[1].int(), range_2[0].int(), range_2[1].int(), []int{}, false}
		} else if state == 1 {
			myticket = line.split(',').map(it.int())
		} else if state == 2 {
			ticket_fields := line.split(',').map(it.int())
			mut is_valid := true
			for ticket_field in ticket_fields {
				mut field_is_valid := false
				for field in fields {
					if (ticket_field >= field.range_1_min &&
						ticket_field <= field.range_1_max) ||
						(ticket_field >= field.range_2_min && ticket_field <= field.range_2_max) {
						field_is_valid = true
						break
					}
				}
				if !field_is_valid {
					is_valid = false
					break
				}
			}
			if is_valid {
				valid_tickets << ticket_fields
			}
		}
	}
	for mut field in fields {
		for i in 0 .. fields.len {
			mut mismatch := false
			for ticket in valid_tickets {
				if !((ticket[i] >= field.range_1_min &&
					ticket[i] <= field.range_1_max) ||
					(ticket[i] >= field.range_2_min && ticket[i] <= field.range_2_max)) {
					mismatch = true
					break
				}
			}
			if !mismatch {
				println('$field.name matches $i')
				field.matching << i
			}
		}
	}
	mut done := false
	for !done {
		done = true
		for mut field in fields {
			if field.matching.len == 1 && !field.matched {
				field.matched = true
				println('100% match $field.name to ${field.matching[0]}')
				for mut ofield in fields {
					if ofield.name != field.name && field.matching[0] in ofield.matching {
						ofield.matching = ofield.matching.filter(it != field.matching[0])
					}
				}
				done = false
				break
			}
		}
	}
	mut result := i64(1)
	for field in fields {
		if field.name.starts_with('departure') {
			result *= myticket[field.matching[0]]
		}
	}
	return result
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) ?
	if '-b' in cmdline.only_options(os.args) {
		solution := solve_b(input)
		println('Solution is: $solution')
	} else {
		solution := solve_a(input)
		println('Solution is: $solution')
	}
}
