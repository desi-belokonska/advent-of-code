require 'set'
require_relative 'common'

# Day 8 of Advent of code
class Day08 < Common
  def part1
    steps_to_end('AAA', 'ZZZ')
  end

  def part2
    current_nodes = map.keys.filter { |node| node.match?(/^\w\wA$/) }
    all_multiples = Set.new

    current_nodes.each do |current_node|
      all_multiples.merge(multiples(steps_to_end(current_node, /^\w\wZ$/)))
    end

    all_multiples.inject(&:*)
  end

  private

  def multiples(num)
    multiples = Set.new
    multiple = 2

    while multiple != num
      while (num % multiple).zero?
        multiples.merge([multiple, num / multiple])
        num /= multiple
      end
      multiple += 1
    end

    multiples
  end

  def steps_to_end(start_node, end_node)
    steps = 0
    current_node = start_node

    instructions.cycle do |instr|
      return steps if current_node.match?(end_node)

      current_node = map[current_node][instr]
      steps += 1
    end
  end

  def instructions
    @instructions ||= lines.first.chars.map(&:to_sym)
  end

  def map
    @map ||= nodes(lines.drop(2))
  end

  def nodes(network)
    network.each_with_object({}) do |line, hash|
      key, left, right = line.scan(/\w+/)
      hash[key] = { L: left, R: right }
    end
  end
end
