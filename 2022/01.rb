require './common'

# Day 1 of Advent of code
class Day01 < Common
  def part1
    split_arr(lines) { |line| line != '' }
      .map { |c| c.map(&:to_i).sum }
      .max
  end

  def part2
    split_arr(lines) { |line| line != '' }
      .map { |c| c.map(&:to_i).sum }
      .sort { |x, y| y <=> x }
      .take(3)
      .sum
  end

  def split_arr(arr, &pred)
    res = []
    until arr.empty?
      chunk = arr.take_while(&pred)

      res << chunk

      arr = arr.drop chunk.size + 1
    end
    res
  end
end
