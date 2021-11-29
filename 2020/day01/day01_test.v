module main

fn test_solve_a() {
	solution := solve_a([1721, 979, 366, 299, 675, 1456]) or {
		assert false
		return
	}
	assert solution == 514579
}

fn test_solve_b() {
	solution := solve_b([1721, 979, 366, 299, 675, 1456]) or {
		assert false
		return
	}
	assert solution == 241861950
}

fn test_badsolve_a() {
	solve_a([0, 1, 2, 3, 4, 5, 6, 7]) or {
		assert err.str() == 'No solution found'
		return
	}
	assert false
}

fn test_badsolve_b() {
	solve_b([0, 1, 2, 3, 4, 5, 6, 7]) or {
		assert err.str() == 'No solution found'
		return
	}
	assert false
}
