require './common'

# Day 1 of Advent of code
class Day01 < Common
  DIGIT_MAP = {
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

  def part1
    lines.sum do |line|
      first_digit = line[/\d/]
      last_digit = line.reverse[/\d/]
      "#{first_digit}#{last_digit}".to_i
    end
  end

  def part2
    lines.sum do |line|
      first_digit = find_digit(line, :first)
      last_digit = find_digit(line, :last)
      "#{first_digit}#{last_digit}".to_i
    end
  end

  private

  def find_digit(str, position)
    regex = if position == :first
              /(one|two|three|four|five|six|seven|eight|nine|ten|\d).*$/
            else
              /^.*(one|two|three|four|five|six|seven|eight|nine|ten|\d)/
            end
    match = regex.match(str)
    convert_to_digit(match.captures.first)
  end

  def convert_to_digit(str)
    DIGIT_MAP[str] || str.to_i
  end
end
