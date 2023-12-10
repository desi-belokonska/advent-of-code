require 'set'
require './common'

# Day 10 of Advent of code
class Day10 < Common
  def part1
    came_from_left = [start_pos].to_set
    came_from_right = [start_pos].to_set
    left, right = starting_pipes(start_pos)
    until left == right
      came_from_left << left
      left = next_pipe(left, came_from_left)

      came_from_right << right
      right = next_pipe(right, came_from_right)
    end

    came_from_right.length
  end

  private

  def starting_pipes(pos)
    starting_pipes = []

    north = north_of(pos)
    if north
      north_pipe = grid[north[0]][north[1]]
      starting_pipes << north if ['|', '7', 'F'].include?(north_pipe)
    end
    south = south_of(pos)
    if south
      south_pipe = grid[south[0]][south[1]]
      starting_pipes << south if ['|', 'L', 'J'].include?(south_pipe)
    end
    west = west_of(pos)
    if west
      west_pipe = grid[west[0]][west[1]]
      starting_pipes << west if ['-', 'F', 'L'].include?(west_pipe)
    end
    east = east_of(pos)
    if east
      east_pipe = grid[east[0]][east[1]]
      starting_pipes << east if ['-', '7', 'J'].include?(east_pipe)
    end

    starting_pipes
  end

  # returns array of gear positions [row, col]
  def connecting_pipes(pos, came_from)
    connecting_pipes = []

    pipe = grid[pos[0]][pos[1]]
    north = north_of(pos)
    south = south_of(pos)
    west = west_of(pos)
    east = east_of(pos)
    case pipe
    when '|'
      # north and south
      connecting_pipes << north if north
      connecting_pipes << south if south
    when '-'
      # west and east
      connecting_pipes << west if west
      connecting_pipes << east if east
    when 'L'
      # north and east
      connecting_pipes << north if north
      connecting_pipes << east if east
    when 'J'
      # north and west
      connecting_pipes << north if north
      connecting_pipes << west if west
    when '7'
      # south and west
      connecting_pipes << south if south
      connecting_pipes << west if west
    when 'F'
      # south and east
      connecting_pipes << south if south
      connecting_pipes << east if east
    when 'S'
      p 'starting position'
    end

    connecting_pipes.filter { |p| !came_from.include?(p) }
  end

  def next_pipe(pos, came_from)
    pipe = grid[pos[0]][pos[1]]
    north = north_of(pos)
    south = south_of(pos)
    west = west_of(pos)
    east = east_of(pos)
    case pipe
    when '|'
      # north and south
      return north if north && !came_from.include?(north)
      return south if south && !came_from.include?(south)
    when '-'
      # west and east
      return west if west && !came_from.include?(west)
      return east if east && !came_from.include?(east)
    when 'L'
      # north and east
      return north if north && !came_from.include?(north)
      return east if east && !came_from.include?(east)
    when 'J'
      # north and west
      return north if north && !came_from.include?(north)
      return west if west && !came_from.include?(west)
    when '7'
      # south and west
      return south if south && !came_from.include?(south)
      return west if west && !came_from.include?(west)
    when 'F'
      # south and east
      return south if south && !came_from.include?(south)
      return east if east && !came_from.include?(east)
      # when 'S'
      #   p 'starting position'
    end
  end

  def start_pos
    @start_pos ||= proc {
      grid.each_with_index do |row, row_idx|
        row.each_with_index do |col, col_idx|
          return [row_idx, col_idx] if col == 'S'
        end
      end
    }.call
  end

  # | is a vertical pipe connecting north and south.
  # - is a horizontal pipe connecting east and west.
  # L is a 90-degree bend connecting north and east.
  # J is a 90-degree bend connecting north and west.
  # 7 is a 90-degree bend connecting south and west.
  # F is a 90-degree bend connecting south and east.
  # . is ground; there is no pipe in this tile.
  # S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.
  def connectable?(pos_a, pos_b); end

  def north_of(pos)
    [pos[0] - 1, pos[1]] if pos[0] - 1 >= 0
  end

  def south_of(pos)
    [pos[0] + 1, pos[1]] if pos[0] + 1 < col_length
  end

  def east_of(pos)
    [pos[0], pos[1] + 1] if pos[1] + 1 < row_length
  end

  def west_of(pos)
    [pos[0], pos[1] - 1] if pos[1] - 1 >= 0
  end

  def grid
    @grid ||= lines.map(&:chars)
  end

  def row_length
    grid[0].length
  end

  def col_length
    grid.length
  end
end
