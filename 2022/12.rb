require './common'
require 'set'

# Day 12 of Advent of code
class Day12 < Common
  attr_reader :rows, :initial_start, :finish, :all_starts
  attr_accessor :path_steps

  ALPHABET_MAP = ('a'..'z').zip(0..).to_h.freeze
  SPECIAL_MAP = { 'S' => -1, 'E' => 26 }.freeze

  def initialize
    super

    @initial_start = [0, 0]
    @all_starts = []
    @finish = [0, 0]

    @rows = lines.each_with_index.map do |line, r|
      line.chars.each_with_index.map do |char, c|
        @initial_start = [r, c] if char == 'S'
        @all_starts << [r, c] if %w[S a].include?(char)
        @finish = [r, c] if char == 'E'
        ALPHABET_MAP[char] || SPECIAL_MAP[char]
      end
    end

    @path_steps = { [finish[0], finish[1]] => 0 }
  end

  def part1
    generate_paths_reverse(r: finish[0], c: finish[1], start: initial_start)
    path_steps[initial_start]
  end

  def part2
    all_starts.map do |start|
      generate_paths_reverse(r: finish[0], c: finish[1], start: start)
    end

    all_starts.map { |start| path_steps[start] }.compact.min
  end

  private

  def generate_paths_reverse(r:, c:, steps: 0, visited: Set.new, start: initial_start)
    return if start == [r, c]

    possible_next = [[r, c - 1], [r, c + 1], [r - 1, c], [r + 1, c]].select do |row, col|
      next if row.negative? || col.negative? || rows[row].nil? || rows[row][col].nil? || visited.include?([row, col])

      rows[r][c] - rows[row][col] <= 1
    end

    # caclulate steps for each possible next
    possible_next.each do |row, col|
      next unless path_steps[[row, col]].nil? || path_steps[[row, col]] > steps + 1

      path_steps[[row, col]] = steps + 1
      generate_paths_reverse(r: row, c: col, steps: steps + 1, visited: visited.dup.add([row, col]))
    end
  end
end
