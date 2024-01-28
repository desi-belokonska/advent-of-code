require './common'

# Day 5 of Advent of code
class Day05 < Common
  def part1
    lines.count { |line| naive_nice?(line) }
  end

  def part2
    lines.count { |line| nice?(line) }
  end

  private

  def nice?(str)
    two_pairs?(str) && repeat_with_one_letter_between?(str)
  end

  def two_pairs?(str)
    # (..).*\1 matches any two characters, then any characters, then the same two characters
    str =~ /(..).*\1/
  end

  def repeat_with_one_letter_between?(str)
    # (.).\1 matches any character, then any character, then the first character again
    str =~ /(.).\1/
  end

  def naive_nice?(str)
    vowels?(str) && double_letter?(str) && !bad_string?(str)
  end

  def vowels?(str)
    vowels = 'aeiou'
    str.count(vowels) >= 3
  end

  def double_letter?(str)
    # (.)\1 matches any character and then the same character
    str =~ /(.)\1/
  end

  def bad_string?(str)
    %w[ab cd pq xy].any? { |bad_str| str.include?(bad_str) }
  end
end
