module main

import os
import os.cmdline

const (
	required   = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
	eye_colors = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth']
)

fn parse(lines []string) []map[string]string {
	mut passports := []map[string]string{}
	mut current := map[string]string{}
	for line in lines {
		if line == '' {
			passports.push(current)
			current = map[string]string{}
		} else {
			parts := line.split(' ')
			for part in parts {
				key_value := part.split(':')
				current[key_value[0]] = key_value[1]
			}
		}
	}
	if current.len > 0 {
		passports.push(current)
	}
	return passports
}

fn solve_a(passports []map[string]string) int {
	mut valid := 0
	for passport in passports {
		mut is_valid := true
		for r in required {
			if r !in passport {
				is_valid = false
				break
			}
		}
		if is_valid {
			valid++
		}
	}
	return valid
}

fn solve_b(passports []map[string]string) int {
	mut valid := 0
	for passport in passports {
		mut is_valid := true
		for r in required {
			if r !in passport {
				is_valid = false
				break
			}
		}
		if is_valid {
			byr := passport['byr'].int()
			if byr < 1920 || byr > 2002 {
				is_valid = false
			}
			iyr := passport['iyr'].int()
			if iyr < 2010 || iyr > 2020 {
				is_valid = false
			}
			eyr := passport['eyr'].int()
			if eyr < 2020 || eyr > 2030 {
				is_valid = false
			}
			hgt := passport['hgt']
			if hgt.ends_with('cm') {
				hgt_cm := hgt[0..hgt.len - 2].int()
				if hgt_cm < 150 || hgt_cm > 193 {
					is_valid = false
				}
			} else if hgt.ends_with('in') {
				hgt_in := hgt[0..hgt.len - 2].int()
				if hgt_in < 59 || hgt_in > 76 {
					is_valid = false
				}
			} else {
				is_valid = false
			}
			hcl := passport['hcl']
			if hcl[0] == `#` {
				if hcl.bytes().filter((it >= 0x30 &&
					it <= 0x39) ||
					(it >= 0x61 && it <= 0x66)).len != 6 {
					is_valid = false
				}
			} else {
				is_valid = false
			}
			ecl := passport['ecl']
			if ecl !in eye_colors {
				is_valid = false
			}
			pid := passport['pid']
			if pid.bytes().filter(it >= 0x30 && it <= 0x39).len != 9 {
				is_valid = false
			}
			if is_valid {
				valid++
			}
		}
	}
	return valid
}

fn main() {
	input_file := os.args[1]
	input := os.read_lines(input_file) ?
	passports := parse(input)
	mut solution := 0
	if '-b' in cmdline.only_options(os.args) {
		solution = solve_b(passports)
	} else {
		solution = solve_a(passports)
	}
	println('Solution is: $solution')
}
