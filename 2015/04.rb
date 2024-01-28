require './common'
require 'digest'

# Day 4 of Advent of code
class Day04 < Common
  def part1
    1.upto(1_000_000_000_000) do |i|
      md5 = md5("#{input}#{i}")
      return i if md5.start_with?('00000')
    end
  end

  def part2
    1.upto(1_000_000_000_000) do |i|
      md5 = md5("#{input}#{i}")
      return i if md5.start_with?('000000')
    end
  end

  private

  def input
    test? ? test_input : 'iwrupvqb'
  end

  def test_input
    'abcdef'
  end

  def md5(str)
    Digest::MD5.hexdigest(str)
  end
end
