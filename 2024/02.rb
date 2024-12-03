require_relative '../common'

class Day02 < Common
  def part1
    lines.filter_map.count do |line|
      report = line.split(' ').map(&:to_i).each_cons(2).map { |a, b| b - a }
      safely_increasing = report.all? do |level|
        level.positive? && level.abs >= 1 && level.abs <= 3
      end
      safely_decreasing = report.all? do |level|
        level.negative? && level.abs >= 1 && level.abs <= 3
      end

      safely_increasing || safely_decreasing
    end
  end

  def part2
    lines.filter_map.count do |line|
      report = line.split(' ').map(&:to_i)

      (0..report.length).any? do |i|
        report_dup = report.dup
        report_dup.delete_at(i)

        report_distances = report_dup.each_cons(2).map { |a, b| b - a }

        safely_increasing = report_distances.all? do |level|
          level.positive? && level.abs >= 1 && level.abs <= 3
        end
        safely_decreasing = report_distances.all? do |level|
          level.negative? && level.abs >= 1 && level.abs <= 3
        end

        safely_increasing || safely_decreasing
      end
    end
  end
end
