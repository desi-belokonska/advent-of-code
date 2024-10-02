require_relative '../common'

class Day18 < Common
  def part1
    # puts 'Initial state:'
    # print_lights(lights)

    current_lights = lights

    100.times do |_i|
      # puts "\nAfter #{i + 1} step:"

      current_lights = current_lights.each_with_index.map do |row, r|
        row.each_with_index.map do |light, c|
          n = neighbors_on(r, c, current_lights).length
          if light == 1 && ![2, 3].include?(n)
            0
          elsif light == 0 && n == 3
            1
          else
            light
          end
        end
      end

      # print_lights(current_lights)
    end
    # print_lights(current_lights)
    current_lights.flatten.sum
  end

  private

  def print_lights(lights)
    lights.each do |row|
      puts row.map { |ch| ch == 1 ? '#' : '.' }.join
    end
  end

  def lights
    @lights ||= lines.map do |line|
      line.split('').map { |ch| ch == '#' ? 1 : 0 }
    end
  end

  def neighbors_on(row, col, lights)
    rows = [row - 1, row, row + 1].filter { |r| r >= 0 && r < lights.length }
    cols = [col - 1, col, col + 1].filter { |c| c >= 0 && c < lights.first.length }
    rows.product(cols).filter { |(r, c)| lights[r][c] == 1 && [r, c] != [row, col] }
  end
end
