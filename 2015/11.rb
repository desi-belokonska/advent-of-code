require_relative '../common'
require 'set'

class Day11 < Common
  def part1
    password = lines.first
    password = increment_password(password) until valid_password?(password)
    password
  end

  def part2
    password = increment_password(part1)
    password = increment_password(password) until valid_password?(password)
    password
  end

  private

  def increment_password(pass)
    pass.next unless pass.next.length != pass.length
  end

  def valid_password?(pass)
    increasing_straight = pass.split('').each_cons(3).any? do |a, b, c|
      a.next == b && b.next == c
    end
    no_forbidden_letters = !pass.match?(/[iol]/)
    at_least_two_pairs = pass.scan(/([a-z])\1/).uniq.length >= 2

    increasing_straight && no_forbidden_letters && at_least_two_pairs
  end
end
