module main

import flag
import os

enum ParamterMode {
	position
	immediate
}

fn challenge_a(input_lines []string) ?i64 {
	mut mem := input_lines[0].split(',').map(it.int())
	mut pointer := 0
	mut last_out := -1
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
				mem[dest] = 1
				pointer += 2
			}
			4 {
				source := mem[pointer + 1]
				last_out = mem[source]
				pointer += 2
			}
			99 {
				break
			}
			else {
				return error('invalid instruction: $instr at $pointer')
			}
		}
	}
	return last_out
}

fn challenge_b(input_lines []string, input int) ?i64 {
	mut mem := input_lines[0].split(',').map(it.int())
	mut pointer := 0
	mut last_out := -1
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
				mem[dest] = input
				pointer += 2
			}
			4 {
				source1 := mem[pointer + 1]
				value1 := if param_0 == .immediate { source1 } else { mem[source1] }
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
				break
			}
			else {
				return error('invalid instruction: $instr at $pointer')
			}
		}
	}
	return last_out
}

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('AdventOfCode 2019 day 05')
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
	solution := if !is_b { challenge_a(input_lines) ? } else { challenge_b(input_lines, 5) ? }
	println('Solution is $solution')
}
