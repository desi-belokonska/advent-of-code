require './common'

# Day 6 of Advent of code
class Day06 < Common
  def part1
    find_marker(4)
  end

  def part2
    find_marker(14)
  end

  private

  def find_marker(cons)
    lines.first.chars.each_with_index.each_cons(cons) do |slice|
      chars = slice.map(&:first)
      indexes = slice.map(&:last)

      return indexes.last + 1 if chars.uniq.size == cons
    end
  end
end
