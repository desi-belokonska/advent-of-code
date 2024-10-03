require_relative '../common'

class Day18 < Common
  def part1
    current_lights = initial_lights

    100.times do
      current_lights = current_lights.each_with_index.map do |row, r|
        row.each_with_index.map do |light, c|
          light_state(light, neighbors_on(r, c, current_lights))
        end
      end
    end

    current_lights.flatten.sum
  end

  def part2
    current_lights = initial_lights
    fix_lights(current_lights)

    100.times do
      current_lights = current_lights.each_with_index.map do |row, r|
        row.each_with_index.map do |light, c|
          next 1 if fixed_lights.include?([r, c])

          light_state(light, neighbors_on(r, c, current_lights))
        end
      end
    end

    current_lights.flatten.sum
  end

  private

  def initial_lights
    @initial_lights ||= lines.map do |line|
      line.split('').map { |ch| ch == '#' ? 1 : 0 }
    end
  end

  def fixed_lights
    @fixed_lights ||= [[0, 0], [0, initial_lights.first.length - 1], [initial_lights.length - 1, 0], [initial_lights.length - 1, initial_lights.first.length - 1]]
  end

  def fix_lights(lights)
    fixed_lights.each do |(r, c)|
      lights[r][c] = 1
    end
  end

  def print_lights(lights)
    lights.each do |row|
      puts row.map { |ch| ch == 1 ? '#' : '.' }.join
    end
  end

  def neighbors_on(row, col, lights)
    rows = [row - 1, row, row + 1].filter { |r| r >= 0 && r < lights.length }
    cols = [col - 1, col, col + 1].filter { |c| c >= 0 && c < lights.first.length }
    rows.product(cols).filter { |(r, c)| lights[r][c] == 1 && [r, c] != [row, col] }.length
  end

  def light_state(light, neighbors)
    if light == 1 && ![2, 3].include?(neighbors)
      0
    elsif light == 0 && neighbors == 3
      1
    else
      light
    end
  end
end
