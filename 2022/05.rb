require './common'

# Day 5 of Advent of code
class Day05 < Common
  def part1
    stacks, moves = stacks_and_moves

    moves.each do |times, from, to|
      times.times do
        elem = stacks[from].shift
        stacks[to].unshift(elem)
      end
    end

    stacks.compact.map(&:first).join
  end

  def part2
    stacks, moves = stacks_and_moves

    moves.each do |n, from, to|
      elems = stacks[from].shift(n)
      stacks[to].unshift(*elems)
    end

    stacks.compact.map(&:first).join
  end

  private

  def stacks_and_moves
    stacks = []
    moves = []

    lines.each do |line|
      if line.start_with?('move')
        triple = line.scan(/move (\d+) from (\d+) to (\d+)/).flatten.map(&:to_i)

        moves << triple
        next
      end

      (1..line.size).step(4) do |i|
        n = i / 4 + 1
        stacks[n] = [] if stacks[n].nil?
        stacks[n] << line[i] if line[i].match?(/\w/)
      end
    end

    [stacks, moves]
  end
end
