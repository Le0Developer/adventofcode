import flag
import os

fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.version('v0.1.0')
	fp.skip_executable()
	fp.limit_free_args_to_exactly(2) ?
	additional_args := fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}
	year := additional_args[0]
	day := additional_args[1]

	if year.len != 4 {
		eprintln('invalid year')
		return
	}
	if day.len != 2 {
		eprintln('invalid day')
		return
	}

	if !os.exists('$year/day$day/v') {
		os.mkdir_all('$year/day$day/v') ?
	}

	day_xx := ($embed_file('templates/v/dayXX.v')).to_string()
	data := day_xx.replace('AdventOfCode 202_ day __', 'AdventOfCode $year day $day')
	os.write_file('$year/day$day/v/day${day}.v', data) ?
	day_xx_test := ($embed_file('templates/v/dayXX_test.v')).to_string()
	os.write_file('$year/day$day/v/day${day}_test.v', day_xx_test) ?
	os.write_file('$year/day$day/v/input.txt', '') ?

	mut readme := os.read_lines('README.md') ?
	mut table_start := -1
	mut found := false
	for i, line in readme {
		if line.starts_with('|  $year  |') {
			mut pretty_day := day
			if pretty_day[0] == `0` {
				pretty_day = ' ' + pretty_day[1..2]
			}
			languages := line.split('|')[3].trim_space()
			readme[i] = '|  $year  |    $pretty_day/25    |  ${' '.repeat(8 - languages.len)}$languages  |'
			found = true
			break
		}
		if line == '|  Year  |  Progress   |  Language(s)  |' {
			table_start = i
		}
	}
	if !found {
		mut pretty_day := day
		if pretty_day[0] == `0` {
			pretty_day = ' ' + pretty_day[1..2]
		}
		readme.insert(table_start + 2, '|  $year  |    $pretty_day/25    |   V           |')
	}

	readme << '' // read_lines removes final newline
	os.write_file('README.md', readme.join_lines()) ?
}
