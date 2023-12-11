require 'set'
require_relative '../common'

# Day 11 of Advent of code
class Day11 < Common
  def part1
    galaxies.combination(2).map do |a, b|
      manhattan(a, b) + number_of_empty_rows_between(a, b) + number_of_empty_cols_between(a, b)
    end.sum
  end

  def part2
    galaxies.combination(2).map do |a, b|
      manhattan(a, b) + number_of_empty_rows_between(a, b) * 999_999 + number_of_empty_cols_between(a, b) * 999_999
    end.sum
  end

  private

  def grid
    @grid ||= lines.map(&:chars)
  end

  def empty_rows
    @empty_rows ||= proc {
      grid.each_with_index.filter_map do |row, i|
        i unless row.include?('#')
      end.to_set
    }.call
  end

  def empty_cols
    @empty_cols ||= proc {
      grid.transpose.each_with_index.filter_map do |col, i|
        i unless col.include?('#')
      end.to_set
    }.call
  end

  @@empty_rows_bewteen_cache = {}

  def number_of_empty_rows_between(pos_a, pos_b)
    return @@empty_rows_bewteen_cache[[pos_a, pos_b]] if @@empty_rows_bewteen_cache.key?([pos_a, pos_b])

    min_row, max_row = [pos_a[0], pos_b[0]].minmax
    num = min_row.upto(max_row).count do |i|
      empty_rows.include?(i)
    end
    @@empty_rows_bewteen_cache[[pos_a, pos_b]] = num
    @@empty_rows_bewteen_cache[[pos_b, pos_a]] = num
    num
  end

  @@empty_cols_between_cache = {}

  def number_of_empty_cols_between(pos_a, pos_b)
    return @@empty_cols_between_cache[[pos_a, pos_b]] if @@empty_cols_between_cache.key?([pos_a, pos_b])

    min_col, max_col = [pos_a[1], pos_b[1]].minmax
    num = min_col.upto(max_col).count do |i|
      empty_cols.include?(i)
    end

    @@empty_cols_between_cache[[pos_a, pos_b]] = num
    @@empty_cols_between_cache[[pos_b, pos_a]] = num
    num
  end

  def galaxies
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
