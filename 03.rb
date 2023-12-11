require_relative 'common'

# Day 3 of Advent of code
class Day03 < Common
  def part1
    lines.each_with_index.flat_map do |line, row|
      find_numbers_with_positions(line).filter_map do |num, start_col, end_col|
        num if adjacent_to_symbol?(row, start_col, end_col)
      end
    end.sum
  end

  def part2
    # key is position ([row, col]), value is numbers
    gears = Hash.new { |hash, key| hash[key] = [] }

    lines.each_with_index do |line, row|
      find_numbers_with_positions(line).each do |num, start_col, end_col|
        find_adjacent_gears(row, start_col, end_col).each do |pos|
          gears[pos].push(num)
        end
      end
    end

    gears
      .values
      .filter_map { |nums| nums.inject(&:*) if nums.length == 2 }
      .sum
  end

  private

  def grid
    @grid ||= lines.map(&:chars)
  end

  # returns numbers and their position as [number, start_col, end_col]
  def find_numbers_with_positions(line)
    line.enum_for(:scan, /\d+/).map do
      match = Regexp.last_match
      [match[0].to_i, match.begin(0), match.end(0) - 1]
    end
  end

  def row_length
    grid[0].length
  end

  # returns array of gear positions [row, col]
  def find_adjacent_gears(row, start_col, end_col)
    gears = []

    (-1..1).each do |dx|
      check_row = row + dx
      next unless check_row.between?(0, grid.length - 1)

      (start_col - 1..end_col + 1).each do |check_col|
        next unless check_col.between?(0, row_length - 1)

        gears.push([check_row, check_col]) if grid[check_row][check_col] == '*'
      end
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
end
