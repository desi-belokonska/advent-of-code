require_relative '../common'

require 'set'

class Day16 < Common
  SUE = {
    'children' => 3,
    'cats' => 7,
    'samoyeds' => 2,
    'pomeranians' => 3,
    'akitas' => 0,
    'vizslas' => 0,
    'goldfish' => 5,
    'trees' => 3,
    'cars' => 2,
    'perfumes' => 1
  }.freeze

  def part1
    lines.find do |line|
      match = line.match(/Sue \d+: (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)/)

      potential_sue = match.captures.each_slice(2).each_with_object({}) do |(element, times), has|
        has[element] = times.to_i
      end

      partial_match?(SUE, potential_sue)
    end
  end

  private

  def partial_match?(full, partial)
    full.to_set.superset?(partial.to_set)
  end
end
