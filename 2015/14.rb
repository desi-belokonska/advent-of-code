require_relative '../common'
require 'set'

class Day14 < Common
  def part1
    time = 2503

    lines.map do |line|
      match = line.match(%r{(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds.})
      name = match[1]
      speed = match[2].to_i
      max_time_at_speed = match[3].to_i
      rest_time = match[4].to_i

      distance = Array.new(max_time_at_speed, speed).concat(Array.new(rest_time, 0)).cycle.take(time).sum
      puts "#{name}: #{distance}"

      distance
    end.max
  end
end
