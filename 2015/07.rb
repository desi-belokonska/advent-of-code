require './common'

# Day 7 of Advent of code
class Day07 < Common
  def part1
    evaluate('a')
  end

  private

  def instruction_map
    @instruction_map ||= lines.map do |line|
      instructions, wire = line.split(' -> ')
      [wire, instructions]
    end.to_h
  end

  def result_map
    @result_map ||= {}
  end

  def evaluate(wire)
    instruction = instruction_map[wire]

    result = case instruction
             when /^(\w+) AND (\w+)$/
               compute_signal(Regexp.last_match(1)) & compute_signal(Regexp.last_match(2))
             when /^(\w+) OR (\w+)$/
               compute_signal(Regexp.last_match(1)) | compute_signal(Regexp.last_match(2))
             when /^(\w+) LSHIFT (\d+)$/
               compute_signal(Regexp.last_match(1)) << Regexp.last_match(2).to_i
             when /^(\w+) RSHIFT (\d+)$/
               compute_signal(Regexp.last_match(1)) >> Regexp.last_match(2).to_i
             when /^NOT (\w+)$/
               ~compute_signal(Regexp.last_match(1))
             else
               compute_signal(instruction)
             end

    result_map[wire] = result
    result
  end

  # compute the signal for a wire or number
  def compute_signal(signal)
    case signal
    when /^(\d+)$/ # number
      signal.to_i
    when /^(\w+)$/ # wire
      result_map[signal] || evaluate(signal)
    end
  end
end
