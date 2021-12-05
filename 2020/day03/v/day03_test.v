module main

const (
	input = ['..##.......', '#...#...#..', '.#....#..#.', '..#.#...#.#', '.#...##..#.', '..#.##.....',
		'.#.#.#....#', '.#........#', '#.##...#...', '#...##....#', '.#..#...#.#']
)

fn test_solve_a() {
	trees := parse(input)
	assert solve_a(trees, 1, 3) == 7
}

fn test_solve_b() {
	trees := parse(input)
	assert solve_b(trees) == 336
}
