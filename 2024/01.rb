require_relative '../common'

class Day01 < Common
  def part1
    lft, rgt = lines.map { |line| line.split(' ').map(&:to_i) }
                    .transpose
                    .map(&:sort)

    lft.zip(rgt).map { |a, b| (a - b).abs }.sum
  end

  def part2
    lft, rgt = lines.map { |line| line.split(' ').map(&:to_i) }
                    .transpose

    lft.sum(0) do |n|
      n * rgt.count { |m| m == n }
    end
  end
end
