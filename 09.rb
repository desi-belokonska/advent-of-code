require 'set'
require './common'

# Day 9 of Advent of code
class Day09 < Common
  def part1
    histories.sum do |history|
      backfill(differences(history))
    end
  end

  def part2
    histories.sum do |history|
      frontfill(differences(history))
    end
  end

  private

  def histories
    @histories ||= lines.map { |line| line.scan(/-?\d+/).map(&:to_i) }
  end

  def difference_sequence(sequence)
    sequence.each_cons(2).map do |prv, nxt|
      nxt - prv
    end
  end

  def differences(initial_sequence)
    all_sequences = [initial_sequence]
    seq = initial_sequence
    until seq.all?(&:zero?)
      seq = difference_sequence(seq)
      all_sequences << seq
    end

    all_sequences
  end

  def backfill(sequences)
    diff = 0
    sequences.reverse.map do |sequence|
      new_last = sequence.last + diff
      sequence << new_last
      diff = new_last
    end.last
  end

  def frontfill(sequences)
    diff = 0
    sequences.reverse.map do |sequence|
      new_fst = sequence.first - diff
      sequence.prepend(new_fst)
      diff = new_fst
    end.last
  end
end
