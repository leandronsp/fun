module MinimumPathSum
  def min_recursive(grid, i = 0, j = 0)
    return grid[i][j] if i == grid.length - 1 && j == grid[0].length - 1

    return grid[i][j] + min_recursive(grid, i + 1, j) if j == grid[0].length - 1
    return grid[i][j] + min_recursive(grid, i, j + 1) if i == grid.length - 1

    down = min_recursive(grid, i + 1, j)
    right = min_recursive(grid, i, j + 1)

    grid[i][j] + [down, right].min
  end

  def min_dp(grid)
    grid_size = grid.length
    row_size = grid[0].length
    memo = Array.new(grid_size) { Array.new(row_size) }

    # populate the first cell in memo
    memo[0][0] = grid[0][0]

    # populate the first row
    for jdx in 1...row_size
        right_cell = memo[0][jdx - 1]
        cell = grid[0][jdx]

        memo[0][jdx] = right_cell + cell
    end

    # populate the first column
    for idx in 1...grid_size
        down_cell = memo[idx - 1][0]
        cell = grid[idx][0]

        memo[idx][0] = down_cell + cell
    end

    # fill up the memo table
    for idx in 1...grid_size
        for jdx in 1...row_size
            down_cell = memo[idx - 1][jdx]
            right_cell = memo[idx][jdx - 1]
            cell = grid[idx][jdx]

            memo[idx][jdx] = [down_cell, right_cell].min + cell
        end
    end

    memo[grid_size - 1][row_size - 1]
  end
end
