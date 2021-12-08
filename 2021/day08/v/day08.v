module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut total := 0
	for line in input_lines {
		groups := line.all_after('|').trim_space().split(' ')
		for group in groups {
			if group.len == 2 || group.len == 3 || group.len == 4 || group.len == 7 {
				total++
			}
		}
	}
	return total
}

enum Side {
	a
	b
	c
	d
	e
	f
	g
}

fn challenge_b(input_lines []string) ?i64 {
	mut total := 0
	all_sides := (1 << 7) - 1
	side_map := {
		`a`: Side.a
		`b`: Side.b
		`c`: Side.c
		`d`: Side.d
		`e`: Side.e
		`f`: Side.f
		`g`: Side.g
	}
	for line in input_lines {
		mut possible := [all_sides, all_sides, all_sides, all_sides, all_sides, all_sides, all_sides]!
		groups := line.all_before('|').trim_space().split(' ')
		for group in groups {
			mut mask := byte(0)
			for char in group {
				mask |= 1 << int(side_map[char])
			}
			sidemask := match group.len {
				2 { // can only be 1
					// possible[Side.c] &= mask
					// possible[Side.f] &= mask
					0b0010010
				}
				3 { // can only be 7
					// possible[Side.a] &= mask
					// possible[Side.c] &= mask
					// possible[Side.f] &= mask
					0b1010010
				}
				4 { // can only be 4
					// possible[Side.b] &= mask
					// possible[Side.c] &= mask
					// possible[Side.d] &= mask
					// possible[Side.f] &= mask
					0b0111010
				}
				5 { // can be: 2, 3, 5
					// they only share the top, mid and bottom sides
					// possible[Side.a] &= mask
					// possible[Side.d] &= mask
					// possible[Side.g] &= mask
					0b1001001
				}
				6 { // can be: 0, 6, 9
					// they share every side except two
					// possible[Side.a] &= mask
					// possible[Side.b] &= mask
					// possible[Side.f] &= mask
					// possible[Side.g] &= mask
					0b1100011
				}
				7 { // can only be 8
					// doesn't reveal any useful information
					all_sides
				}
				else {
					panic('impossible group: $group')
				}
			}
			is_clear := group.len == 2 || group.len == 3 || group.len == 4 || group.len == 7
			for side in 0 .. 7 {
				if sidemask & (1 << side) > 0 {
					possible[side] &= mask
				} else if is_clear {
					// possible[side] ^= possible[side] & mask
				}
			}
		}
		mut solutionmap := [-1, -1, -1, -1, -1, -1, -1]!
		mut remaining_sides := all_sides
		for {
			mut changed := false
			for side in 0 .. 7 {
				if solutionmap[side] >= 0 {
					continue
				}
				for i, possible_side in possible {
					if possible_side & remaining_sides == 1 << side {
						solutionmap[side] = i
						remaining_sides ^= 1 << side
						changed = true
						break
					}
				}
			}
			if !changed {
				break
			}
		}
		output := line.all_after('|').trim_space().split(' ')
		mut solution := []string{}
		for group in output {
			mut mask := byte(0)
			for char in group {
				mask |= 1 << solutionmap[int(side_map[char])]
			}
			match mask {
				0b1110111 { // 0
					solution << '0'
				}
				0b0010010 { // 1
					solution << '1'
				}
				0b1011101 { // 2
					solution << '2'
				}
				0b1011011, 0b1101101 { // 3
					solution << '3'
				}
				0b0111010 { // 4
					solution << '4'
				}
				0b1101011 { // 5
					solution << '5'
				}
				0b1101111 { // 6
					solution << '6'
				}
				0b1010010 { // 7
					solution << '7'
				}
				0b1111111 { // 8
					solution << '8'
				}
				0b1111011 { // 9
					solution << '9'
				}
				else {
					panic('invalid solution')
				}
			}
		}
		total += solution.join('').int()
	}
	return total
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 08')
	fp.version('v0.1.0')
	fp.skip_executable()
	fp.limit_free_args_to_exactly(1) ?
	is_b := fp.bool('b', `b`, false, 'b challenge')
	// more options here
	additional_args := fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}
	input_filename := additional_args[0]
	input_lines := os.read_lines(input_filename) ?
	solution := if !is_b { challenge_a(input_lines) ? } else { challenge_b(input_lines) ? }
	println('Solution is $solution')
}
