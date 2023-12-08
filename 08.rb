require './common'

# Day 8 of Advent of code
class Day08 < Common
  def part1
    steps_to_end('AAA', 'ZZZ')
  end

  private

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
