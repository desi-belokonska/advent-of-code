require './common'

# Day 8 of Advent of code
class Day08 < Common
  attr_reader :rows, :columns

  def initialize
    super
    @rows = lines.map { |line| line.chars.map(&:to_i) }
    @columns = rows.transpose
  end

  def part1
    rows.each_with_index.map do |row, i|
      row.each_with_index.map do |n, j|
        visible?(i, j, n)
      end
    end.flatten.select { |v| v }.count
  end

  def part2
    rows.each_with_index.map do |row, i|
      row.each_with_index.map do |n, j|
        scenic_score(i, j, n)
      end
    end.flatten.max
  end

  def visible?(i, j, n)
    directions = directions(i, j)

    directions.any?(&:empty?) || directions.any? { |direction| direction.all? { |num| num < n } }
  end

  def scenic_score(i, j, n)
    directions = directions(i, j)

    directions.map do |direction|
      distance = direction.take_while do |t|
        t < n
      end.count
      next_tree = direction.drop(distance).first
      distance += 1 unless next_tree.nil?
      distance
    end.flatten.reduce(:*)
  end

  def directions(i, j)
    left = rows[i][0...j].reverse
    right = rows[i][j + 1..]

    up = columns[j][0...i].reverse
    down = columns[j][i + 1..]

    [left, right, up, down]
  end
end
