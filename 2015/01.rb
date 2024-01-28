require './common'

# Day 1 of Advent of code
class Day01 < Common
  def part1
    lines.first.split('').map { |c| c == '(' ? 1 : -1 }.sum
  end

  def part2
    basement_position = 0
    floor = 0
    lines.first.split('').each_with_index do |c, i|
      floor += c == '(' ? 1 : -1
      basement_position = i + 1 if floor == -1 && basement_position.zero?
    end
    basement_position
  end
end
