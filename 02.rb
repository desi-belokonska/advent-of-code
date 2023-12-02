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
    invalid = Set.new

    lines.each do |line|
      game = /Game (?<game>\d+):/.match(line).match(:game).to_i
      games.add(game)

      rest = line.gsub(/Game (?<game>\d+):/, '')
      rest.split(';').each do |record|
        red = /(\d+) red/.match(record)&.match(1).to_i || 0
        green = /(\d+) green/.match(record)&.match(1).to_i || 0
        blue = /(\d+) blue/.match(record)&.match(1).to_i || 0

        invalid.add(game) if red + blue + green > 39
        invalid.add(game) if red > MAX[:red]
        invalid.add(game) if green > MAX[:green]
        invalid.add(game) if blue > MAX[:blue]
      end
    end

    (games - invalid).sum
  end
end
