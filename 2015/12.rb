require_relative '../common'
require 'set'

class Day12 < Common
  def part1
    lines.first.scan(/-?\d+/).map(&:to_i).sum
  end
end
