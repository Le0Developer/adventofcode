module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	numbers := input_lines[0].split(',').map(it.int())
	mut revealed_numbers := map[int]bool{}
	mut boards := [][][]int{}
	for i in 0 .. ((input_lines.len - 1) / 6) {
		mut board := [][]int{}
		for j in 0 .. 5 {
			board << input_lines[i * 6 + j + 2].trim_space().replace('  ', ' ').split(' ').map(it.int())
		}
		boards << board
	}
	for i in numbers {
		revealed_numbers[i] = true
		for board in boards {
			mut found := false
			for k in 0 .. 5 {
				if board[k].all(it in revealed_numbers) {
					found = true
					break
				}
				if board.all(it[k] in revealed_numbers) {
					found = true
					break
				}
			}
			if found {
				// sum would be nice
				mut total := 0
				for k in board {
					for unmarked in k.filter(it !in revealed_numbers) {
						total += unmarked
					}
				}
				return i * total
			}
		}
	}
	return -1
}

fn challenge_b(input_lines []string) ?i64 {
	numbers := input_lines[0].split(',').map(it.int())
	mut revealed_numbers := map[int]bool{}
	mut boards := [][][]int{}
	for i in 0 .. ((input_lines.len - 1) / 6) {
		mut board := [][]int{}
		for j in 0 .. 5 {
			board << input_lines[i * 6 + j + 2].trim_space().replace('  ', ' ').split(' ').map(it.int())
		}
		boards << board
	}
	mut boards_that_didnt_win := []int{}
	for i in numbers {
		revealed_numbers[i] = true
		mut boards_that_still_didnt_win := []int{}
		for j, board in boards {
			mut found := false
			for k in 0 .. 5 {
				if board[k].all(it in revealed_numbers) {
					found = true
					break
				}
				if board.all(it[k] in revealed_numbers) {
					found = true
					break
				}
			}
			if !found {
				boards_that_still_didnt_win << j
			}
		}
		if boards_that_still_didnt_win.len == 0 {
			board := boards[boards_that_didnt_win[0]]
			// sum would be nice
			mut total := 0
			for k in board {
				for unmarked in k.filter(it !in revealed_numbers) {
					total += unmarked
				}
			}
			return i * total
		}
		boards_that_didnt_win = boards_that_still_didnt_win.clone()
	}
	return -1
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 04')
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
	input_lines := os.read_lines(input_filename) !
	solution := if !is_b { challenge_a(input_lines) ? } else { challenge_b(input_lines) ? }
	println('Solution is $solution')
}
