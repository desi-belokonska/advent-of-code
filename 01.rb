require './common'

# Day 1 of Advent of code
class Day01 < Common
  def part1
    lines.sum do |line|
      fst = /^\D*(\d)/.match(line)
      snd = /(\d)\D*$/.match(line)
      [fst.captures.first, snd.captures.first].join.to_i
    end
  end
end
