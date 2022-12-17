module main

import os
import os.cmdline

const (
	floor    = -1
	empty    = 0
	occupied = 1
)

fn parse(input []string) [][]int {
	mut seats := [][]int{}
	for line in input {
		mut row := []int{}
		for character in line {
			if character == `L` {
				row << empty
			} else {
				row << floor
			}
		}
		seats << row
	}
	return seats
}

fn solve_a(seats_ [][]int) int {
	mut done := false
	mut seats := seats_.clone()
	for !done {
		done = true
		mut new := [][]int{}
		for y in 0 .. seats.len {
			mut row := []int{}
			for x in 0 .. seats[y].len {
				if seats[y][x] == floor {
					row << floor
					continue
				}
				mut adjacent := 0
				if y > 0 {
					if seats[y - 1][x] == occupied {
						adjacent++
					}
					if x > 0 && seats[y - 1][x - 1] == occupied {
						adjacent++
					}
					if x + 1 < seats[y - 1].len && seats[y - 1][x + 1] == occupied {
						adjacent++
					}
				}
				if y + 1 < seats.len {
					if seats[y + 1][x] == occupied {
						adjacent++
					}
					if x > 0 && seats[y + 1][x - 1] == occupied {
						adjacent++
					}
					if x + 1 < seats[y + 1].len && seats[y + 1][x + 1] == occupied {
						adjacent++
					}
				}
				if x > 0 && seats[y][x - 1] == occupied {
					adjacent++
				}
				if x + 1 < seats[y].len && seats[y][x + 1] == occupied {
					adjacent++
				}
				mut value := seats[y][x]
				if adjacent == 0 && value == empty {
					value = occupied
					done = false
				}
				if adjacent >= 4 && value == occupied {
					value = empty
					done = false
				}
				row << value
			}
			new << row
		}
		seats = new.clone()
	}
	mut count := 0
	for row in seats {
		for value in row {
			if value == occupied {
				count++
			}
		}
	}
	return count
}

fn solve_b(seats_ [][]int) int {
	mut done := false
	mut seats := seats_.clone()
	for !done {
		done = true
		mut new := [][]int{}
		for y in 0 .. seats.len {
			mut row := []int{}
			for x in 0 .. seats[y].len {
				if seats[y][x] == floor {
					row << floor
					continue
				}
				mut adjacent := 0
				mut ny := 0
				mut nx := 0
				ny = y - 1
				for ny >= 0 {
					if seats[ny][x] >= empty {
						if seats[ny][x] == occupied {
							adjacent++
						}
						break
					}
					ny--
				}
				ny = y - 1
				nx = x - 1
				for ny >= 0 && nx >= 0 {
					if seats[ny][nx] >= empty {
						if seats[ny][nx] == occupied {
							adjacent++
						}
						break
					}
					ny--
					nx--
				}
				ny = y - 1
				nx = x + 1
				for ny >= 0 && nx < seats[ny].len {
					if seats[ny][nx] >= empty {
						if seats[ny][nx] == occupied {
							adjacent++
						}
						break
					}
					ny--
					nx++
				}
				ny = y + 1
				for ny < seats.len {
					if seats[ny][x] >= empty {
						if seats[ny][x] == occupied {
							adjacent++
						}
						break
					}
					ny++
				}
				ny = y + 1
				nx = x - 1
				for ny < seats.len && nx >= 0 {
					if seats[ny][nx] >= empty {
						if seats[ny][nx] == occupied {
							adjacent++
						}
						break
					}
					ny++
					nx--
				}
				ny = y + 1
				nx = x + 1
				for ny < seats.len && nx < seats[ny].len {
					if seats[ny][nx] >= empty {
						if seats[ny][nx] == occupied {
							adjacent++
						}
						break
					}
					ny++
					nx++
				}
				nx = x - 1
				for nx >= 0 {
					if seats[y][nx] >= empty {
						if seats[y][nx] == occupied {
							adjacent++
						}
						break
					}
					nx--
				}
				nx = x + 1
				for nx < seats[y].len {
					if seats[y][nx] >= empty {
						if seats[y][nx] == occupied {
							adjacent++
						}
						break
					}
					nx++
				}
				mut value := seats[y][x]
				if adjacent == 0 && value == empty {
					value = occupied
					done = false
				}
				if adjacent >= 5 && value == occupied {
					value = empty
					done = false
				}
				row << value
			}
			new << row
		}
		seats = new.clone()
	}
	mut count := 0
	for row in seats {
		for value in row {
			if value == occupied {
				count++
			}
		}
	}
	return count
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) !
	seats := parse(input)
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(seats)
	} else {
		solution = solve_a(seats)
	}
	println('Solution is: $solution')
}
