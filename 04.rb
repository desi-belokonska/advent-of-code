require 'set'
require './common'

# Day 4 of Advent of code
class Day04 < Common
  def part1
    lines.sum do |line|
      matching = matching_numbers(line)
      matching.empty? ? 0 : 2**(matching.size - 1)
    end
  end

  private

  def matching_numbers(line)
    winning_str, have_str = line.split(':')[1].split('|')
    winning = winning_str.scan(/\d+/).map(&:to_i).to_set
    have = have_str.scan(/\d+/).map(&:to_i).to_set

    winning & have
  end
end
