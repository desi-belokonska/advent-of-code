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
      game = /Game (?<game>\d+):/.match(line).match(:game).to_i

      rest = line.gsub(/Game (?<game>\d+):/, '')
      rest.split(';').each do |record|
        red = /(\d+) red/.match(record)&.match(1).to_i || 0
        green = /(\d+) green/.match(record)&.match(1).to_i || 0
        blue = /(\d+) blue/.match(record)&.match(1).to_i || 0

        games[game][:red] = red if red > games[game][:red]
        games[game][:green] = green if green > games[game][:green]
        games[game][:blue] = blue if blue > games[game][:blue]
      end
    end

    games.sum { |_, game| game[:red] * game[:green] * game[:blue] }
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
    cubes.default_proc = proc { 0 }
    cubes
  end

  def invalid_game?(cubes)
    cubes.any? { |color, count| count > MAX[color] } || cubes.values.sum > 39
  end
end
