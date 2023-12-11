require 'set'
require './common'

# Day 11 of Advent of code
class Day11 < Common
  def part1
    galaxies.combination(2).map do |a, b|
      manhattan(a, b)
    end.sum
  end

  private

  def full_grid
    @full_grid ||= lines.map(&:chars)
  end

  def expanded_grid(scale = 2)
    @expanded_grid ||= proc {
      # expand grid by duplicating empty rows
      new_grid = full_grid.flat_map do |row|
        row.include?('#') ? [row] : Array.new(scale, row)
      end

      # expand grid by duplicating empty columns
      new_grid.transpose.flat_map do |col|
        col.include?('#') ? [col] : Array.new(scale, col)
      end.transpose
    }.call
  end

  def galaxies(grid = expanded_grid)
    @galaxies ||= proc {
      grid.flat_map.with_index do |row, i|
        row.filter_map.with_index do |col, j|
          [i, j] if col == '#'
        end
      end
    }.call
  end

  def manhattan(pos_a, pos_b)
    (pos_a[0] - pos_b[0]).abs + (pos_a[1] - pos_b[1]).abs
  end
end
