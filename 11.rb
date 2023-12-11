require 'set'
require './common'

# Day 11 of Advent of code
class Day11 < Common
  def part1
    # aljdlkfs
    # puts expanded_grid.map(&:join).join("\n")
    # p galaxies

    distances = Hash.new(Float::INFINITY)
    p galaxies.length
    galaxies.each do |g|
      paths_from_g = bfs(g)
      paths_from_g.each do |k, v|
        distances[[g, k].to_set] = v if galaxies.include?(k) && k != g
      end
    end
    distances.values.sum
  end

  private

  def grid
    @grid ||= lines.map(&:chars)
  end

  def expanded_grid
    @expanded_grid ||= proc {
      # expand grid by duplicating empty rows
      new_grid = grid.flat_map do |row|
        row.include?('#') ? [row] : [row, row]
      end

      # expand grid by duplicating empty columns
      new_grid.transpose.flat_map do |col|
        col.include?('#') ? [col] : [col, col]
      end.transpose
    }.call
  end

  def galaxies
    @galaxies ||= proc {
      expanded_grid.flat_map.with_index do |row, i|
        row.filter_map.with_index do |col, j|
          [i, j] if col == '#'
        end
      end
    }.call
  end

  def bfs(start)
    p start
    queue = [start]
    distances = { start => 0 }
    distances.default = Float::INFINITY
    while queue.any?
      current = queue.shift
      neighbors(current).each do |neighbor|
        if distances[neighbor] == Float::INFINITY
          distances[neighbor] = distances[current] + 1
          queue << neighbor
        end
      end
    end
    distances
  end

  def neighbors(pos)
    row, col = pos
    [
      [row - 1, col],
      [row + 1, col],
      [row, col - 1],
      [row, col + 1]
    ].filter_map do |neighbor|
      unless (0...expanded_grid.length).include?(neighbor[0]) && (0...expanded_grid[0].length).include?(neighbor[1])
        next
      end

      neighbor
    end
  end
end
