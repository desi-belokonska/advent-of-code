require 'set'
require_relative 'common'

# Day 10 of Advent of code
class Day10 < Common
  def part1
    loop_positions.length / 2
  end

  # even-odd rule
  def part2
    inside = []
    (0...row_length).each do |row|
      is_inside = false
      flat_wall_start = nil
      (0...col_length).each do |col|
        pipe = grid[row][col]

        if loop_positions.include?([row, col])
          case pipe
          when '|'
            is_inside = !is_inside
          when 'F', 'L'
            flat_wall_start = pipe
          when 'J', '7'
            if flat_wall_start == 'F' && pipe == 'J' ||
               flat_wall_start == 'L' && pipe == '7'
              is_inside = !is_inside
            end
            flat_wall_start = nil
          end
        elsif is_inside
          inside << [row, col]
        end
      end
    end
    inside.length
  end

  private

  def loop_positions
    @loop_positions ||= proc {
      came_from = [start_tile].to_set
      right = starting_pipe(start_tile)
      until right.nil?
        came_from << right
        right = next_pipe(right, came_from)
      end
      came_from
    }.call
  end

  # picks the first pipe connected to S
  def starting_pipe(pos)
    north = north_of(pos)
    if north
      north_pipe = grid[north[0]][north[1]]
      return north if ['|', '7', 'F'].include?(north_pipe)
    end
    south = south_of(pos)
    if south
      south_pipe = grid[south[0]][south[1]]
      return south if ['|', 'L', 'J'].include?(south_pipe)
    end
    west = west_of(pos)
    if west
      west_pipe = grid[west[0]][west[1]]
      return west if ['-', 'F', 'L'].include?(west_pipe)
    end
    east = east_of(pos)
    if east
      east_pipe = grid[east[0]][east[1]]
      return east if ['-', '7', 'J'].include?(east_pipe)
    end

    nil
  end

  # | is a vertical pipe connecting north and south.
  # - is a horizontal pipe connecting east and west.
  # L is a 90-degree bend connecting north and east.
  # J is a 90-degree bend connecting north and west.
  # 7 is a 90-degree bend connecting south and west.
  # F is a 90-degree bend connecting south and east.
  # . is ground; there is no pipe in this tile.
  # S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.

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
    end
  end

  def start_tile
    @start_tile ||= proc {
      grid.each_with_index do |row, row_idx|
        row.each_with_index do |col, col_idx|
          return [row_idx, col_idx] if col == 'S'
        end
      end
    }.call
  end

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
