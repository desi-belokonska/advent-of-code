require './common'

# Day 2 of Advent of code
class Day02 < Common
  def part1
    lines.map do |line|
      paper_length(dimensions(line))
    end.sum
  end

  def part2
    lines.map do |line|
      ribbon_length(dimensions(line)) + bow_length(dimensions(line))
    end.sum
  end

  private

  def dimensions(line)
    line.split('x').map(&:to_i)
  end

  def ribbon_length(dimensions)
    dimensions.sort[0..1].sum * 2
  end

  def bow_length(dimensions)
    dimensions.inject(:*)
  end

  def paper_length(dimensions)
    l, w, h = dimensions
    smallest = [l * w, w * h, h * l].min
    2 * l * w + 2 * w * h + 2 * h * l + smallest
  end
end
