require_relative '../common'

class Day03 < Common
  def part1
    lines.sum do |line|
      line.scan(/mul\(-?\d+,-?\d+\)/).map { |expr| eval(expr) }.sum
    end
  end

  def part2
    enabled = true

    lines.sum do |line|
      line.scan(/do\(\)|don't\(\)|mul\(-?\d+,-?\d+\)/).filter_map do |expr|
        case expr
        when 'do()'
          enabled = true
          next
        when "don't()"
          enabled = false
          next
        else
          eval(expr) if enabled
        end
      end.sum
    end
  end

  private

  def mul(a, b)
    a * b
  end
end
