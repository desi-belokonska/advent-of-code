require './common'

# Day 6 of Advent of code
class Day06 < Common
  def part1
    times = lines[0].scan(/\d+/).map(&:to_i)
    distances = lines[1].scan(/\d+/).map(&:to_i)
    times.zip(distances).map do |time, distance|
      ways_to_win(time, distance)
    end.inject(&:*)
  end

  def part2
    time = lines[0].scan(/\d+/).join.to_i
    distance = lines[1].scan(/\d+/).join.to_i
    ways_to_win(time, distance)
  end

  def ways_to_win(time, distance_to_beat)
    time_to_hold = 1
    ways_to_win = 0

    while time_to_hold < time
      time_to_travel = time - time_to_hold
      distance = time_to_hold * time_to_travel
      ways_to_win += 1 if distance > distance_to_beat
      time_to_hold += 1
    end

    ways_to_win
  end
end
