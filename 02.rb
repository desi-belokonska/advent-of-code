require 'set'
require './common'

# Day 2 of Advent of code
class Day02 < Common
  MAX = {
    red: 12,
    green: 13,
    blue: 14
  }.freeze

  def part1
    games = Set.new

    lines.each do |line|
      game_id, game_data = parse_game_line(line)
      games.add(game_id)

      game_data.each do |record|
        cubes = extract_cubes(record)
        games.delete(game_id) if invalid_game?(cubes)
      end
    end

    games.sum
  end

  def part2
    games = Hash.new { |hash, key| hash[key] = { red: 0, green: 0, blue: 0 } }

    lines.each do |line|
      game_id, game_data = parse_game_line(line)

      game_data.each do |record|
        cubes = extract_cubes(record)
        update_maximum_cubes(games[game_id], cubes)
      end
    end

    calculate_total_power(games)
  end

  private

  def parse_game_line(line)
    game_id = line[/Game (\d+):/, 1].to_i
    game_data = line.split(':')[1].split(';')
    [game_id, game_data]
  end

  def extract_cubes(record)
    colors = %i[red green blue]
    cubes = colors.map { |color| [color, record[/(\d+) #{color}/, 1].to_i] }.to_h
    cubes.default = 0
    cubes
  end

  def invalid_game?(cubes)
    cubes.any? { |color, count| count > MAX[color] } || cubes.values.sum > 39
  end

  def update_maximum_cubes(game_cubes, new_cubes)
    new_cubes.each { |color, count| game_cubes[color] = count if count > game_cubes[color] }
  end

  def calculate_total_power(games)
    games.values.map { |cubes| cubes.values.inject(:*) }.sum
  end
end
