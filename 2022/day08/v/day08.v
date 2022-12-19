module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut treemap := [][]u8{}
	for line in input_lines {
		mut row := []u8{}
		for character in line {
			row << character - `0`
		}
		treemap << row
	}
	height := treemap.len
	width := treemap[0].len
	mut visible := height * 2 + width * 2 - 4
	for i in 1 .. height - 1 {
		for j in 1 .. width - 1 {
			value := treemap[i][j]
			mut still_visible := 4
			for di := i + 1; di < height; di++ {
				if treemap[di][j] >= value {
					still_visible--
					break
				}
			}
			for di := i - 1; di >= 0; di-- {
				if treemap[di][j] >= value {
					still_visible--
					break
				}
			}
			for dj := j + 1; dj < width; dj++ {
				if treemap[i][dj] >= value {
					still_visible--
					break
				}
			}
			for dj := j - 1; dj >= 0; dj-- {
				if treemap[i][dj] >= value {
					still_visible--
					break
				}
			}
			if still_visible > 0 {
				// print(still_visible)
				visible++
			} else {
				// print(' ')
			}
		}
		//println('')
	}
	return visible
}

fn challenge_b(input_lines []string) ?i64 {
	mut treemap := [][]u8{}
	for line in input_lines {
		mut row := []u8{}
		for character in line {
			row << character - `0`
		}
		treemap << row
	}
	height := treemap.len
	width := treemap[0].len

	mut highest_score := 0

	for i in 1 .. height - 1 {
		for j in 1 .. width - 1 {
			value := treemap[i][j]
			mut dd := 1 // distance Down
			mut du := 1 // Up
			mut dr := 1 // Right
			mut dl := 1 // Left

			for i + dd + 1 < height && treemap[i + dd][j] < value {
				dd++
			}
			for i - du > 0 && treemap[i - du][j] < value {
				du++
			}
			for j + dr + 1 < width && treemap[i][j + dr] < value {
				dr++
			}
			for j - dl > 0 && treemap[i][j - dl] < value {
				dl++
			}

			score := dd * du * dr * dl
			// print('$dd$du$dr$dl ')
			// print(score)
			if score > highest_score {
				highest_score = score
			}
		}
		// println('')
	}
	return highest_score
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2022 day 08')
	fp.version('v0.1.0')
	fp.skip_executable()
	fp.limit_free_args_to_exactly(1)!
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
