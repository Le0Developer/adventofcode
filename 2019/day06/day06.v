module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut connections := {'COM': 0}
	mut total := 0
	for {
		mut changed := false
		for line in input_lines {
			parts := line.split(')')
			if parts[0] !in connections || parts[1] in connections { continue }
			value := connections[parts[0]] or { 0 } + 1
			connections[parts[1]] = value
			total += value
			changed = true
		}
		if !changed { break }
	}
	return total
}

fn challenge_b(input_lines []string) ?i64 {
	mut connections := {'COM': 0}
	for {
		mut changed := false
		for line in input_lines {
			parts := line.split(')')
			if parts[0] !in connections || parts[1] in connections { continue }
			value := connections[parts[0]] or { 0 } + 1
			connections[parts[1]] = value
			changed = true
		}
		if !changed { break }
	}
	// the strategy here is finding a common orbit with the least distance to COM
	// then calculating the distance from that to each other
	mut san := {'SAN': true}
	for {
		mut changed := false
		for line in input_lines {
			parts := line.split(')')
			if parts[0] in san || parts[1] !in san { continue }
			san[parts[0]] = true
			changed = true
		}
		if !changed { break }
	}
	mut you := {'YOU': true}
	for {
		for line in input_lines {
			parts := line.split(')')
			if parts[0] in you || parts[1] !in you { continue }
			if parts[0] in san {
				dis_san := connections['SAN'] - connections[parts[0]] - 1
				dis_you := connections['YOU'] - connections[parts[0]] - 1
				return dis_you + dis_san
			}
			you[parts[0]] = true
		}
	}
	return -1
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2019 day 06')
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
