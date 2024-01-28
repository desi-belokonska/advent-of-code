require './common'

# Day 3 of Advent of code
class Day03 < Common
  def part1
    pos = [0, 0]
    lines.first.split('').each_with_object({ [0, 0] => true }) do |dir, houses|
      pos = move(dir, pos)
      houses[pos] = true
    end.size
  end

  def part2
    santa_pos = [0, 0]
    robo_pos = [0, 0]
    houses = { [0, 0] => true }
    lines.first.split('').each_with_index do |dir, i|
      santa_pos = move(dir, santa_pos) if i.even?
      robo_pos = move(dir, robo_pos) if i.odd?
      houses[santa_pos] = true
      houses[robo_pos] = true
    end

    houses.size
  end

  private

  def move(dir, pos)
    x, y = pos
    case dir
    when '^'
      [x, y + 1]
    when 'v'
      [x, y - 1]
    when '<'
      [x - 1, y]
    when '>'
      [x + 1, y]
    end
  end
end
