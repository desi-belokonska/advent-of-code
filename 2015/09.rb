require_relative '../common'
require 'set'

# Day 9 of Advent of code
class Day09 < Common
  def part1
    loc_distances.min
  end

  def part2
    loc_distances.max
  end

  private

  def loc_distances
    locations = Set.new
    distances = {}

    lines.each do |line|
      line =~ /(\w+) to (\w+) = (\d+)/
      locations << Regexp.last_match(1)
      locations << Regexp.last_match(2)
      distances[[Regexp.last_match(1), Regexp.last_match(2)]] = Regexp.last_match(3).to_i
      distances[[Regexp.last_match(2), Regexp.last_match(1)]] = Regexp.last_match(3).to_i
    end

    locations.to_a.permutation.filter_map do |chain|
      chain.each_cons(2).sum do |pair|
        distances[pair]
      end
    end
  end
end
