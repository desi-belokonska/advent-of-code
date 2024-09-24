require_relative '../common'
require 'set'

class Day10 < Common
  def part1
    seq = input.clone
    40.times do
      seq = look_and_say(seq)
    end
    seq.join.length
  end

  def part2
    seq = input.clone
    50.times do
      seq = look_and_say(seq)
    end
    seq.join.length
  end

  private

  def input
    @input ||= lines.first.split('')
  end

  def look_and_say(seq)
    n = 0
    digit = seq.first
    new_seq = []

    loop do
      if seq.first == digit
        n += 1
        seq.shift
      else
        new_seq.push(n.to_s, digit)
        break if seq.empty?

        n = 0
        digit = seq.first
      end
    end

    new_seq
  end
end
