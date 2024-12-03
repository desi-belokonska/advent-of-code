require_relative '../common'

class Day03 < Common
  def part1
    lines.sum do |line|
      line.scan(/mul\(-?\d+,-?\d+\)/).map { |expr| eval(expr) }.sum
    end
  end

  private

  def mul(a, b)
    a * b
  end
end
