require_relative '../common'
require 'set'

class Day14 < Common
  TIME = 2503

  def part1
    stats.map do |name, speed, max_time_at_speed, rest_time|
      distance = Array.new(max_time_at_speed, speed).concat(Array.new(rest_time, 0)).cycle.take(TIME).sum

      [name, distance]
    end.max_by { |_name, dist| dist }
  end

  def part2
    distances = {}

    stats.map do |name, speed, max_time_at_speed, rest_time|
      speeds = Array.new(max_time_at_speed, speed).concat(Array.new(rest_time, 0)).cycle

      distances[name] = (1..TIME).map { |n| speeds.take(n).sum }
    end

    lead_dist = 0
    points = Hash.new { |hash, key| hash[key] = 0 }

    (0...TIME).each do |i|
      reindeers_at_time = distances.transform_values { |dist| dist[i] }
      lead_dist = reindeers_at_time.max_by { |_, v| v }[1]

      reindeers_at_time.filter { |_, v| v == lead_dist }.each_key do |name|
        points[name] += 1
      end
    end

    points.max_by { |_, v| v }
  end

  private

  def stats
    lines.map do |line|
      match = line.match(%r{(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds.})
      name = match[1]
      speed = match[2].to_i
      max_time_at_speed = match[3].to_i
      rest_time = match[4].to_i

      [name, speed, max_time_at_speed, rest_time]
    end
  end
end
