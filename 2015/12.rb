require_relative '../common'
require 'json'

class Day12 < Common
  def part1
    lines.first.scan(/-?\d+/).map(&:to_i).sum
  end

  def part2
    json = JSON.parse!(lines.first)

    sum(json)
  end

  private

  def sum(json)
    case json
    when Hash
      json.value?('red') ? 0 : sum(json.values)
    when Array
      json.map { |val| sum(val) }.sum
    when Integer
      json
    else
      0
    end
  end
end
