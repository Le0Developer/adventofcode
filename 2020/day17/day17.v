module main

import os
import os.cmdline

const (
	inactive = 0
	active   = 1
)

fn parse(input []string) [][]int {
	mut first := [][]int{}
	for line in input {
		mut row := []int{}
		for char in line {
			if char == `#` {
				row << active
			} else {
				row << inactive
			}
		}
		first << row
	}
	return first
}

fn nearby_2d(room [][]int, y int, x int) int {
	mut adjacent := 0
	if room[y][x] == active {
		adjacent++
	}
	if y > 0 {
		if room[y - 1][x] == active {
			adjacent++
		}
		if x > 0 && room[y - 1][x - 1] == active {
			adjacent++
		}
		if x + 1 < room[y - 1].len && room[y - 1][x + 1] == active {
			adjacent++
		}
	}
	if y + 1 < room.len {
		if room[y + 1][x] == active {
			adjacent++
		}
		if x > 0 && room[y + 1][x - 1] == active {
			adjacent++
		}
		if x + 1 < room[y + 1].len && room[y + 1][x + 1] == active {
			adjacent++
		}
	}
	if x > 0 && room[y][x - 1] == active {
		adjacent++
	}
	if x + 1 < room[y].len && room[y][x + 1] == active {
		adjacent++
	}
	return adjacent
}

fn expand_room_3d(room [][][]int) [][][]int {
	mut new := [][][]int{}
	rowlength := room[0][0].len + 2
	linelength := room[0].len + 2
	new << [[inactive].repeat(rowlength)].repeat(linelength)
	for z in 0 .. room.len {
		mut layer := [][]int{}
		layer << [inactive].repeat(rowlength)
		for y in 0 .. room[z].len {
			mut row := [inactive]
			row << room[z][y]
			row << inactive
			layer << row
		}
		layer << [inactive].repeat(rowlength)
		new << layer
	}
	new << [[inactive].repeat(rowlength)].repeat(linelength)
	return new
}

fn expand_room_4d(room [][][][]int) [][][][]int {
	mut new := [][][][]int{}
	whateverlength := room[0].len + 2
	rowlength := room[0][0][0].len + 2
	linelength := room[0][0].len + 2
	new <<
		[[[inactive].repeat(rowlength)].repeat(linelength)].repeat(whateverlength)
	for w in 0 .. room.len {
		mut whatever := [][][]int{}
		whatever << [[inactive].repeat(rowlength)].repeat(linelength)
		for z in 0 .. room[w].len {
			mut layer := [][]int{}
			layer << [inactive].repeat(rowlength)
			for y in 0 .. room[w][z].len {
				mut row := [inactive]
				row << room[w][z][y]
				row << inactive
				layer << row
			}
			layer << [inactive].repeat(rowlength)
			whatever << layer
		}
		whatever << [[inactive].repeat(rowlength)].repeat(linelength)
		new << whatever
	}
	new <<
		[[[inactive].repeat(rowlength)].repeat(linelength)].repeat(whateverlength)
	return new
}

fn print_room_3d(room [][][]int) {
	for z in 0 .. room.len {
		println('\nz=$z')
		for y in 0 .. room[z].len {
			for x in 0 .. room[z][y].len {
				if room[z][y][x] == active {
					print('#')
				} else {
					print('.')
				}
			}
			print('\n')
		}
	}
}

fn print_room_4d(room [][][][]int) {
	for w in 0 .. room.len {
		for z in 0 .. room[w].len {
			println('\nz=$z, w=$w')
			for y in 0 .. room[w][z].len {
				for x in 0 .. room[w][z][y].len {
					if room[w][z][y][x] == active {
						print('#')
					} else {
						print('.')
					}
				}
				print('\n')
			}
		}
	}
}

fn solve_a(input []string) int {
	mut room := [parse(input)]
	for _ in 0 .. 7 {
		room = expand_room_3d(room)
	}
	for _ in 0 .. 6 {
		// print_room_3d(room)
		mut new := [][][]int{}
		for z in 0 .. room.len {
			mut layer := [][]int{}
			for y in 0 .. room[z].len {
				mut row := []int{}
				for x in 0 .. room[z][y].len {
					mut adjacent := nearby_2d(room[z], y, x)
					if room[z][y][x] == active {
						adjacent--
					}
					if z > 0 {
						adjacent += nearby_2d(room[z - 1], y, x)
					}
					if z + 1 < room.len {
						adjacent += nearby_2d(room[z + 1], y, x)
					}
					mut cube := room[z][y][x]
					if cube == active && !(adjacent == 2 || adjacent == 3) {
						cube = inactive
					} else if cube == inactive && adjacent == 3 {
						cube = active
					}
					row << cube
				}
				layer << row
			}
			new << layer
		}
		room = new
	}
	mut count := 0
	for layer in room {
		for row in layer {
			for value in row {
				if value == active {
					count++
				}
			}
		}
	}
	return count
}

fn solve_b(input []string) int {
	mut room := [[parse(input)]]
	for _ in 0 .. 12 {
		room = expand_room_4d(room)
	}
	for _ in 0 .. 6 {
		// print_room_4d(room)
		mut new := [][][][]int{}
		for w in 0 .. room.len {
			mut whatever := [][][]int{}
			for z in 0 .. room.len {
				mut layer := [][]int{}
				for y in 0 .. room[z].len {
					mut row := []int{}
					for x in 0 .. room[z][y].len {
						mut adjacent := nearby_2d(room[w][z], y, x)
						if room[w][z][y][x] == active {
							adjacent--
						}
						if z > 0 {
							adjacent += nearby_2d(room[w][z - 1], y, x)
							if w > 0 {
								adjacent += nearby_2d(room[w - 1][z - 1], y, x)
							}
							if w + 1 < room.len {
								adjacent += nearby_2d(room[w + 1][z - 1], y, x)
							}
						}
						if z + 1 < room[0].len {
							adjacent += nearby_2d(room[w][z + 1], y, x)
							if w > 0 {
								adjacent += nearby_2d(room[w - 1][z + 1], y, x)
							}
							if w + 1 < room.len {
								adjacent += nearby_2d(room[w + 1][z + 1], y, x)
							}
						}
						if w > 0 {
							adjacent += nearby_2d(room[w - 1][z], y, x)
						}
						if w + 1 < room.len {
							adjacent += nearby_2d(room[w + 1][z], y, x)
						}
						mut cube := room[w][z][y][x]
						if cube == active && !(adjacent == 2 || adjacent == 3) {
							cube = inactive
						} else if cube == inactive && adjacent == 3 {
							cube = active
						}
						row << cube
					}
					layer << row
				}
				whatever << layer
			}
			new << whatever
		}
		room = new
	}
	mut count := 0
	for whatever in room {
		for layer in whatever {
			for row in layer {
				for value in row {
					if value == active {
						count++
					}
				}
			}
		}
	}
	return count
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) ?
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(input)
	} else {
		solution = solve_a(input)
	}
	println('Solution is: $solution')
}
