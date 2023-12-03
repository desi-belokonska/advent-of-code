require './common'

# Day 3 of Advent of code
class Day03 < Common
  def part1
    part_numbers = []
    lines.each_with_index do |line, i|
      find_numbers_in_line(line, i).each do |num, pos|
        part_numbers.push(num) if adjacent_to_symbol?(pos)
      end
    end

    part_numbers.sum
  end

  private

  def grid
    @grid ||= lines.map(&:chars)
  end

  # returns numbers and their position as [row, colstart, colend]
  def find_numbers_in_line(line, row)
    # go through the line until you find a number
    # once you find a number, remember it's position
    nums = []

    i = 0

    num_string = ''
    while i <= line.length
      unless num_string.empty? || digit?(line[i])
        nums.push([num_string.to_i, [row, i - num_string.length, i - 1]])
        num_string = ''
      end

      num_string += line[i] if digit?(line[i])
      i += 1
    end

    nums
  end

  def row_length
    grid[0].length
  end

  # position is [row, colstart, colend]
  def adjacent_to_symbol?(position)
    row, colstart, colend = position
    elems = []

    # up
    up = grid.at(row - 1)&.at((colstart - 1)..(colend + 1))
    elems.concat(up) unless up.nil?
    # current line
    current = grid.at(row)&.at((colstart - 1)..(colend + 1))
    elems.concat(current) unless current.nil?
    # down
    down = grid.at(row + 1)&.at((colstart - 1)..(colend + 1))
    elems.concat(down) unless down.nil?

    /[^0-9.]/.match?(elems.join)
  end

  def digit?(str)
    /\d/.match?(str)
  end

  Array.class_eval do
    def at(idx)
      if idx.instance_of?(Range)
        min, max = idx.minmax
        min = 0 if min.negative?
        idx = min..max
      end

      return nil if !idx.instance_of?(Range) && idx.negative?

      self[idx]
    end
  end
end
