require './common'

# Day 3 of Advent of code
class Day03 < Common
  ORD_MAP = [*'a'..'z', *'A'..'Z'].zip(1..).to_h.freeze

  def part1
    lines
      .map(&method(:split_into_two))
      .then(&method(:sum_priorities))
  end

  def part2
    lines
      .each_slice(3)
      .then(&method(:sum_priorities))
  end

  private

  def sum_priorities(arr)
    arr.reduce(0) do |sum, group|
      item = first_common(*group)

      sum + ORD_MAP[item]
    end
  end

  def first_common(*strs)
    strs.map(&:chars).reduce(&:&).first
  end

  def split_into_two(arr)
    half = arr.length / 2
    [arr[0...half], arr[half..]]
  end
end
