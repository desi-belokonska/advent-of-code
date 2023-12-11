require './common'

# Day 4 of Advent of code
class Day04 < Common
  def part1
    ranges.select { |r1, r2| r1.cover?(r2) || r2.cover?(r1) }.count
  end

  def part2
    ranges.select { |r1, r2| r1.overlap?(r2) }.count
  end

  private

  def ranges
    lines.lazy.map do |line|
      fst, snd = line.split(',')

      x1, y1 = fst.split('-').map(&:to_i)
      r1 = Range.new(x1, y1)

      x2, y2 = snd.split('-').map(&:to_i)
      r2 = Range.new(x2, y2)

      [r1, r2]
    end
  end
end

class Range
  def overlap?(other)
    first <= other.last && last >= other.first
  end
end
