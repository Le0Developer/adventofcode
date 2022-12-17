module main

import flag
import os

fn challenge_a(input_lines []string) ?i64 {
	mut flashers := [][]byte{}
	mut total := 0
	for line in input_lines {
		mut row := []byte{}
		for character in line {
			row << character - 0x30
		}
		flashers << row
	}
	dim_y := flashers.len
	dim_x := flashers[0].len
	for _ in 0 .. 100 {
		// println('')
		for y in 0 .. dim_y {
			for x in 0 .. dim_x {
				flashers[y][x]++
			}
		}
		mut flashed := map[string]bool{}
		mut affected := map[string]bool{}
		for y in 0 .. dim_y {
			for x in 0 .. dim_x {
				if flashers[y][x] >= 10 {
					flash(mut flashers, mut flashed, mut affected, y, x)
				}
			}
		}
		total += flashed.len
		for y in 0 .. dim_y {
			for x in 0 .. dim_x {
				if flashers[y][x] >= 10 {
					flashers[y][x] = 0
				}
			}
		}
		// for y in 0 .. dim_y {
		//	for x in 0 .. dim_x {
		//		print(flashers[y][x])
		//	}
		//	println('')
		//}
	}
	return total
}

fn flash(mut flashers [][]byte, mut flashed map[string]bool, mut affected map[string]bool, y int, x int) {
	if '${y}:${x}' in flashed {
		return
	}
	flashed['${y}:${x}'] = true
	dim_y := flashers.len
	dim_x := flashers[0].len
	for vy in -1 .. 2 {
		for vx in -1 .. 2 {
			if vy == 0 && vx == 0 {
				continue
			}
			mut py := y + vy
			mut px := x + vx
			if py >= 0 && px >= 0 && py < dim_y && px < dim_x {
				if '${py}:${px}:${vx}:${vy}' !in affected {
					affected['${py}:${px}:${vx}:${vy}'] = true
					flashers[py][px]++
					if flashers[py][px] >= 10 {
						flash(mut flashers, mut flashed, mut affected, py, px)
					}
				}
			}
		}
	}
}

fn challenge_b(input_lines []string) ?i64 {
	mut flashers := [][]byte{}
	for line in input_lines {
		mut row := []byte{}
		for character in line {
			row << character - 0x30
		}
		flashers << row
	}
	dim_y := flashers.len
	dim_x := flashers[0].len
	mut step := 1
	for {
		// println('')
		for y in 0 .. dim_y {
			for x in 0 .. dim_x {
				flashers[y][x]++
			}
		}
		mut flashed := map[string]bool{}
		mut affected := map[string]bool{}
		for y in 0 .. dim_y {
			for x in 0 .. dim_x {
				if flashers[y][x] >= 10 {
					flash(mut flashers, mut flashed, mut affected, y, x)
				}
			}
		}
		if flashed.len == dim_y * dim_x {
			return step
		}
		for y in 0 .. dim_y {
			for x in 0 .. dim_x {
				if flashers[y][x] >= 10 {
					flashers[y][x] = 0
				}
			}
		}
		step++
		// for y in 0 .. dim_y {
		//	for x in 0 .. dim_x {
		//		print(flashers[y][x])
		//	}
		//	println('')
		//}
	}
	return -1
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2021 day 11')
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
