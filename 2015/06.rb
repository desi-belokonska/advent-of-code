require './common'

# Day 6 of Advent of code
class Day06 < Common
  def part1
    lines { |line| parse(line) }
    lights.flatten.sum
  end

  def part2
    lines { |line| parse_ancient_nordic_elvish(line) }
    lights.flatten.sum
  end

  private

  def parse(line)
    case line
    when /turn on (\d+),(\d+) through (\d+),(\d+)/
      x1, y1, x2, y2 = (1..4).map { |i| ::Regexp.last_match(i).to_i }
      (x1..x2).each do |x|
        (y1..y2).each do |y|
          lights[x][y] = 1
        end
      end
    when /turn off (\d+),(\d+) through (\d+),(\d+)/
      x1, y1, x2, y2 = (1..4).map { |i| ::Regexp.last_match(i).to_i }
      (x1..x2).each do |x|
        (y1..y2).each do |y|
          lights[x][y] = 0
        end
      end
    when /toggle (\d+),(\d+) through (\d+),(\d+)/
      x1, y1, x2, y2 = (1..4).map { |i| ::Regexp.last_match(i).to_i }
      (x1..x2).each do |x|
        (y1..y2).each do |y|
          lights[x][y] = lights[x][y].zero? ? 1 : 0
        end
      end
    end
  end

  def parse_ancient_nordic_elvish(line)
    case line
    when /turn on (\d+),(\d+) through (\d+),(\d+)/
      x1, y1, x2, y2 = (1..4).map { |i| ::Regexp.last_match(i).to_i }
      (x1..x2).each do |x|
        (y1..y2).each do |y|
          lights[x][y] = lights[x][y] + 1
        end
      end
    when /turn off (\d+),(\d+) through (\d+),(\d+)/
      x1, y1, x2, y2 = (1..4).map { |i| ::Regexp.last_match(i).to_i }
      (x1..x2).each do |x|
        (y1..y2).each do |y|
          lights[x][y] = lights[x][y].positive? ? lights[x][y] - 1 : 0
        end
      end
    when /toggle (\d+),(\d+) through (\d+),(\d+)/
      x1, y1, x2, y2 = (1..4).map { |i| ::Regexp.last_match(i).to_i }
      (x1..x2).each do |x|
        (y1..y2).each do |y|
          lights[x][y] = lights[x][y] + 2
        end
      end
    end
  end

  def lights
    @lights ||= Array.new(1000) { Array.new(1000, 0) }
  end
end
