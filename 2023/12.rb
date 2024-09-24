require 'set'
require_relative '../common'

# Day 12 of Advent of code
class Day12 < Common
  def part1
    springs_and_groups.map do |spring_row, groups|
      count_variations(spring_row, groups)
    end.sum
  end

  private

  def cache
    @cache ||= {}
  end

  def count_recursively(spring_row, index, current, groups)
    # Base case: end of the string
    if index == spring_row.length
      return matches?(current, groups) ? 1 : 0
    end

    count = 0
    if spring_row[index] != '?'
      # Continue with the current character
      count += count_recursively(spring_row, index + 1, current + spring_row[index], groups)
    else
      # Explore options: replace '?' with '#' or '.'
      count += count_recursively(spring_row, index + 1, current + '#', groups)
      count += count_recursively(spring_row, index + 1, current + '.', groups)
    end

    count
  end

  def count_variations(spring_row, groups)
    count_recursively(spring_row, 0, '', groups)
  end

  def springs_and_groups
    @springs_and_groups ||= lines.map do |line|
      springs = line.split(' ').first
      groups = line.split(' ').last.split(',').map(&:to_i)
      [springs, groups]
    end
  end

  def matches?(spring_row, group)
    spring_row.split(/\.+/).reject(&:empty?).map(&:length) == group
  end

  def damaged_groups
    @damaged_groups ||= lines.map do |line|
      line.split(' ').last.split(',').map(&:to_i)
    end
  end
end
