require_relative '../common'

# Day 8 of Advent of code
class Day08 < Common
  def part1
    lines.sum do |line|
      line.length - eval(line).length
    end
  end

  def part2
    lines.sum do |line|
      line.inspect.length - line.length
    end
  end
end
