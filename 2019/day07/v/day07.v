module main

import flag
import os

enum ParamterMode {
	position
	immediate
}

fn intcoder(input_lines []string, input []int, phase int) ?int {
	mut mem := input_lines[0].split(',').map(it.int())
	mut pointer := 0
	mut last_out := -1
	mut input_id := 0
	for {
		instr := mem[pointer]
		instrs := instr.str()
		param_0 := if instrs.len >= 3 && instrs[instrs.len - 3] == `1` {
			ParamterMode.immediate
		} else {
			ParamterMode.position
		}
		param_1 := if instrs.len >= 4 && instrs[instrs.len - 4] == `1` {
			ParamterMode.immediate
		} else {
			ParamterMode.position
		}
		// param_2 := if instrs.len >= 5 && instrs[instrs.len - 5] == `1` { ParamterMode.immediate } else { ParamterMode.position }
		match instr % 100 {
			1 {
				source1 := mem[pointer + 1]
				source2 := mem[pointer + 2]
				dest := mem[pointer + 3]
				value1 := if param_0 == .immediate { source1 } else { mem[source1] }
				value2 := if param_1 == .immediate { source2 } else { mem[source2] }
				mem[dest] = value1 + value2
				pointer += 4
			}
			2 {
				source1 := mem[pointer + 1]
				source2 := mem[pointer + 2]
				dest := mem[pointer + 3]
				value1 := if param_0 == .immediate { source1 } else { mem[source1] }
				value2 := if param_1 == .immediate { source2 } else { mem[source2] }
				mem[dest] = value1 * value2
				pointer += 4
			}
			3 {
				dest := mem[pointer + 1]
				if input_id > input.len {
					return error(last_out.str())
				}
				mem[dest] = if input_id == 0 { phase } else { input[input_id - 1] }
				println('input $input_id ${mem[dest]}')
				input_id++
				pointer += 2
			}
			4 {
				source1 := mem[pointer + 1]
				value1 := if param_0 == .immediate { source1 } else { mem[source1] }
				println('output $value1')
				last_out = value1
				pointer += 2
			}
			5 {
				source1 := mem[pointer + 1]
				source2 := mem[pointer + 2]
				value1 := if param_0 == .immediate { source1 } else { mem[source1] }
				value2 := if param_1 == .immediate { source2 } else { mem[source2] }
				if value1 != 0 {
					pointer = value2
				} else {
					pointer += 3
				}
			}
			6 {
				source1 := mem[pointer + 1]
				source2 := mem[pointer + 2]
				value1 := if param_0 == .immediate { source1 } else { mem[source1] }
				value2 := if param_1 == .immediate { source2 } else { mem[source2] }
				if value1 == 0 {
					pointer = value2
				} else {
					pointer += 3
				}
			}
			7 {
				source1 := mem[pointer + 1]
				source2 := mem[pointer + 2]
				dest := mem[pointer + 3]
				value1 := if param_0 == .immediate { source1 } else { mem[source1] }
				value2 := if param_1 == .immediate { source2 } else { mem[source2] }
				mem[dest] = int(value1 < value2)
				pointer += 4
			}
			8 {
				source1 := mem[pointer + 1]
				source2 := mem[pointer + 2]
				dest := mem[pointer + 3]
				value1 := if param_0 == .immediate { source1 } else { mem[source1] }
				value2 := if param_1 == .immediate { source2 } else { mem[source2] }
				mem[dest] = int(value1 == value2)
				pointer += 4
			}
			99 {
				println('exit')
				break
			}
			else {
				return error('invalid instruction: $instr at $pointer')
			}
		}
	}
	return last_out
}

fn intcoder_phase(input_lines []string, phase_a int, phase_b int, phase_c int, phase_d int, phase_e int) int {
	mut output := intcoder(input_lines, [0], phase_a) or { panic(err) }
	output = intcoder(input_lines, [output], phase_b) or { panic(err) }
	output = intcoder(input_lines, [output], phase_c) or { panic(err) }
	output = intcoder(input_lines, [output], phase_d) or { panic(err) }
	output = intcoder(input_lines, [output], phase_e) or { panic(err) }
	return output
}

fn intcoder_b_phase(input_lines []string, phase_a int, phase_b int, phase_c int, phase_d int, phase_e int) int {
	mut value := -1
	mut signals_a := [0]
	mut signals_b := []int{}
	mut signals_c := []int{}
	mut signals_d := []int{}
	mut signals_e := []int{}
	for {
		value = intcoder(input_lines, signals_a, phase_a) or {
			signals_b << err.str().int()
			(-1)
		}
		println('a $value')
		if value != -1 {
			signals_b << value
		}
		value = intcoder(input_lines, signals_b, phase_b) or {
			signals_c << err.str().int()
			(-1)
		}
		println('b $value')
		if value != -1 {
			signals_c << value
		}
		value = intcoder(input_lines, signals_c, phase_c) or {
			signals_d << err.str().int()
			(-1)
		}
		println('c $value')
		if value != -1 {
			signals_d << value
		}
		value = intcoder(input_lines, signals_d, phase_d) or {
			signals_e << err.str().int()
			(-1)
		}
		println('d $value')
		if value != -1 {
			signals_e << value
		}
		value = intcoder(input_lines, signals_e, phase_e) or {
			if signals_a.len == 1 && signals_a[0] == 0 {
				signals_a.clear()
			}
			signals_a << err.str().int()
			(-1)
		}
		println('e $value')
		if value != -1 {
			break
		}
	}
	println(signals_a)
	println(signals_b)
	println(signals_c)
	println(signals_d)
	println(signals_e)
	return value
}

fn challenge_a(input_lines []string) ?i64 {
	mut highest := 0
	for a in 0 .. 5 {
		for b in 0 .. 5 {
			if b == a {
				continue
			}
			for c in 0 .. 5 {
				if c == a || c == b {
					continue
				}
				for d in 0 .. 5 {
					if d == c || d == a || d == b {
						continue
					}
					mut e := 5 - (a + b + c + d) % 5
					if e == 5 {
						e = 0
					}
					value := intcoder_phase(input_lines, a, b, c, d, e)
					if value > highest {
						highest = value
					}
				}
			}
		}
	}
	return highest
}

fn challenge_b(input_lines []string) ?i64 {
	mut highest := 0
	for a in 0 .. 5 {
		for b in 0 .. 5 {
			if b == a {
				continue
			}
			for c in 0 .. 5 {
				if c == a || c == b {
					continue
				}
				for d in 0 .. 5 {
					if d == c || d == a || d == b {
						continue
					}
					mut e := 5 - (a + b + c + d) % 5
					if e == 5 {
						e = 0
					}
					value := intcoder_b_phase(input_lines, 5 + a, 5 + b, 5 + c, 5 + d,
						5 + e)
					if value > highest {
						highest = value
					}
				}
			}
		}
	}
	return highest
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2019 day 07')
	fp.version('v0.1.0')
	fp.skip_executable()
	fp.limit_free_args_to_exactly(1) !
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
