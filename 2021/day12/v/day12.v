module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut connections := map[string][]string{}
	for line in input_lines {
		parts := line.split('-')
		connections[parts[0]] << parts[1]
		connections[parts[1]] << parts[0]
	}
	mut total := 0
	visitor_a(['start'], 'start', connections, mut total)
	return total
}

fn visitor_a(path []string, origin string, connections map[string][]string, mut total &int) {
	for connection in connections[origin] {
		if !connection.is_upper() && connection in path {
			continue
		}
		mut path_clone := path.clone()
		path_clone << connection
		if connection == 'end' {
			total++
		} else {
			visitor_a(path_clone, connection, connections, mut total)
		}
	}
}

fn challenge_b(input_lines []string) ?i64 {
	mut connections := map[string][]string{}
	for line in input_lines {
		parts := line.split('-')
		connections[parts[0]] << parts[1]
		connections[parts[1]] << parts[0]
	}
	mut total := 0
	visitor_b(['start'], 'start', connections, mut total, false)
	return total
}

fn visitor_b(path []string, origin string, connections map[string][]string, mut total &int, already_visited_one_twice bool) {
	for connection in connections[origin] {
		if connection == 'start'
			|| (!connection.is_upper() && connection in path && already_visited_one_twice) {
			continue
		}
		mut path_clone := path.clone()
		path_clone << connection
		if connection == 'end' {
			total++
		} else {
			visitor_b(path_clone, connection, connections, mut total, already_visited_one_twice
				|| (!connection.is_upper() && connection in path))
		}
	}
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 12')
	fp.version('v0.1.0')
	fp.skip_executable()
	fp.limit_free_args_to_exactly(1)?
	is_b := fp.bool('b', `b`, false, 'b challenge')
	// more options here
	additional_args := fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}
	input_filename := additional_args[0]
	input_lines := os.read_lines(input_filename)!
	solution := if !is_b { challenge_a(input_lines)? } else { challenge_b(input_lines)? }
	println('Solution is ${solution}')
}
