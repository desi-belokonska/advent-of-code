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

  def part2
    lines.sum do |line|
      fst = /(one|two|three|four|five|six|seven|eight|nine|ten|\d).*$/.match(line)
      snd = /^.*(one|two|three|four|five|six|seven|eight|nine|ten|\d)/.match(line)
      [to_num(fst.captures.first), to_num(snd.captures.first)].join.to_i
    end
  end

  NUMBERS = {
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9
  }.freeze

  def to_num(str)
    NUMBERS[str] || str.to_i
  end
end
