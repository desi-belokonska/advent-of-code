require_relative 'common'

# Day 6 of Advent of code
class Day06 < Common
  def part1
    times = lines[0].scan(/\d+/).map(&:to_i)
    distances = lines[1].scan(/\d+/).map(&:to_i)
    times.zip(distances).map do |time, distance|
      optimised_ways_to_win(time, distance)
    end.inject(&:*)
  end

  def part2
    time = lines[0].scan(/\d+/).join.to_i
    distance = lines[1].scan(/\d+/).join.to_i
    optimised_ways_to_win(time, distance)
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

  def optimised_ways_to_win(time, distance_to_beat)
    time_to_hold_down = optimal_time_to_hold(time)
    time_to_hold_up = time_to_hold_down
    ways_to_win_down = 0
    ways_to_win_up = 0

    # Counting down
    distance_down = calculate_distance(time_to_hold_down, time)
    while distance_down > distance_to_beat
      ways_to_win_down += 1
      time_to_hold_down -= 1
      distance_down = calculate_distance(time_to_hold_down, time)
    end

    # Counting up
    distance_up = calculate_distance(time_to_hold_up, time)
    while distance_up > distance_to_beat
      ways_to_win_up += 1
      time_to_hold_up += 1
      distance_up = calculate_distance(time_to_hold_up, time)
    end

    # Combine the results and subtract 1 (since the optimal time is counted in both ways)
    ways_to_win_down + ways_to_win_up - 1
  end

  def optimised_ways_to_win_down(time, distance_to_beat)
    time_to_hold = optimal_time_to_hold(time)
    ways_to_win = 0

    distance = calculate_distance(time_to_hold, time)

    while distance > distance_to_beat
      ways_to_win += 1
      time_to_hold -= 1
      distance = calculate_distance(time_to_hold, time)
    end

    ways_to_win
  end

  def calculate_distance(time_to_hold, time)
    time_to_travel = time - time_to_hold
    time_to_hold * time_to_travel
  end

  def optimal_time_to_hold(time)
    # constraints:
    # time_to_hold + time_to_travel = time
    # optimisation (maximise distance):
    # time_to_travel * time_to_hold = distance
    # x = time_to_hold
    # x * (time - x)
    # y = time * x - x**2
    # derivatives:
    # y1 = time - 2x
    # y2 = -2 -> max
    # y1 = 0 -> x = time/2
    (time / 2).floor
    # time_to_travel = time - time_to_hold
    # time_to_hold * time_to_travel
  end
end
