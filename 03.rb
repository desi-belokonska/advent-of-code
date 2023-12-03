require './common'

# Day 3 of Advent of code
class Day03 < Common
  def part1
    lines.each_with_index.flat_map do |line, row|
      numbers_with_positions(line).filter_map do |num, start_col, end_col|
        num if adjacent_to_symbol?(row, start_col, end_col)
      end
    end.sum
  end

  def part2
    # key is position ([row, col]), value is numbers
    gears = Hash.new { |hash, key| hash[key] = [] }

    lines.each_with_index do |line, row|
      numbers_with_positions(line).each do |num, start_col, end_col|
        gears_around([row, start_col, end_col]).each do |gear_position|
          gears[gear_position].push(num)
        end
      end
    end
    gears
      .values
      .filter { |nums| nums.length == 2 }
      .map { |nums| nums.inject(&:*) }
      .sum
  end

  private

  def grid
    @grid ||= lines.map(&:chars)
  end

  # returns numbers and their position as [number, start_col, end_col]
  def numbers_with_positions(line)
    line.enum_for(:scan, /\d+/).map do
      match = Regexp.last_match
      [match[0].to_i, match.begin(0), match.end(0) - 1]
    end
  end

  def row_length
    grid[0].length
  end

  # returns array of gear positions [row, col]
  def gears_around(position)
    row, colstart, colend = position
    gears = []

    # up
    grid.at(row - 1)&.each_with_index do |ch, i|
      gears.push([row - 1, i]) if ((colstart - 1)..(colend + 1)).include?(i) && (ch == '*')
    end

    # current line
    grid.at(row)&.each_with_index do |ch, i|
      gears.push([row, i]) if ((colstart - 1)..(colend + 1)).include?(i) && (ch == '*')
    end

    # down
    grid.at(row + 1)&.each_with_index do |ch, i|
      gears.push([row + 1, i]) if ((colstart - 1)..(colend + 1)).include?(i) && (ch == '*')
    end

    gears
  end

  def adjacent_to_symbol?(row, start_col, end_col)
    (-1..1).any? do |dx|
      check_row = row + dx
      next if check_row.negative? || check_row >= grid.length

      (-1..1).any? do |dy|
        next if dx.zero? && dy.zero?

        (start_col..end_col).any? do |col|
          check_col = col + dy
          next if check_col.negative? || check_col >= row_length

          symbol?(grid[check_row][check_col])
        end
      end
    end
  end

  def symbol?(cell)
    !/\d|\./.match?(cell)
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
