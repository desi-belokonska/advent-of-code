require 'set'
require_relative '../common'

# Day 4 of Advent of code
class Day04 < Common
  def part1
    lines.sum do |line|
      matching = matching_numbers(line)
      matching.empty? ? 0 : 2**(matching.size - 1)
    end
  end

  def part2
    scratchcards = Hash.new { |hash, key| hash[key] = 1 }

    lines.each do |line|
      card_id = line[/Card\s+(\d+):/, 1].to_i
      matching_num = matching_numbers(line).size

      times_owned = scratchcards[card_id]

      matching_num.times do |n|
        next_card_id = card_id + n + 1
        scratchcards[next_card_id] += times_owned if next_card_id <= lines.length
      end
    end

    scratchcards.values.sum
  end

  private

  def matching_numbers(line)
    winning_str, have_str = line.split(':')[1].split('|')
    winning = winning_str.scan(/\d+/).map(&:to_i).to_set
    have = have_str.scan(/\d+/).map(&:to_i).to_set

    winning & have
  end
end
