require './common'

# Day 10 of Advent of code
class Day10 < Common
  def part1
    cycle = 0
    x = 1
    signal_strengths = []
    lines.map do |line|
      if line == 'noop'
        cycle += 1
        signal_strengths << signal_strength(cycle, x) if ((cycle - 20) % 40).zero?
      else
        _, num_s = line.split(' ')
        num = num_s.to_i
        cycle += 1
        signal_strengths << signal_strength(cycle, x) if ((cycle - 20) % 40).zero?
        cycle += 1
        signal_strengths << signal_strength(cycle, x) if ((cycle - 20) % 40).zero?
        x += num
      end
    end

    signal_strengths.sum
  end

  def part2
    cycle = 0
    x = 1
    pixels = []
    lines.map do |line|
      if line == 'noop'
        pixels << (sprite_pos(x, cycle).include?(cycle) ? '#' : '.')
        cycle += 1
      else
        _, num_s = line.split(' ')
        num = num_s.to_i

        print "Cycle: #{cycle}, sprite_pos: #{sprite_pos(x, cycle)}\n"
        pixels << (sprite_pos(x, cycle).include?(cycle) ? '#' : '.')
        cycle += 1

        print "Cycle: #{cycle}, sprite_pos: #{sprite_pos(x, cycle)}\n"
        pixels << (sprite_pos(x, cycle).include?(cycle) ? '#' : '.')
        cycle += 1

        x += num
      end
    end

    pixels.each_slice(40).map do |row|
      print row.join, "\n"
    end

    nil
  end

  def signal_strength(cycle, x)
    cycle * x
  end

  def sprite_pos(x, cycle)
    times_forty = cycle / 40
    normalized_x = x + (times_forty * 40)
    normalized_x - 1..normalized_x + 1
  end
end
