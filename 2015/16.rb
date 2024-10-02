require_relative '../common'

class Day16 < Common
  SUE = {
    'children' => 3,
    'cats' => 7,
    'samoyeds' => 2,
    'pomeranians' => 3,
    'akitas' => 0,
    'vizslas' => 0,
    'goldfish' => 5,
    'trees' => 3,
    'cars' => 2,
    'perfumes' => 1
  }.freeze

  def part1
    find_sue do |potential_sue|
      partial_match?(SUE, potential_sue)
    end
  end

  def part2
    find_sue do |potential_sue|
      real_sue?(SUE, potential_sue)
    end
  end

  private

  def find_sue
    lines.find do |line|
      match = line.match(/Sue \d+: (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)/)

      potential_sue = match.captures.each_slice(2).each_with_object({}) do |(thing, times), has|
        has[thing] = times.to_i
      end

      yield potential_sue
    end
  end

  def partial_match?(full, partial)
    partial.each.all? do |thing, times|
      full[thing] == times
    end
  end

  def real_sue?(real, potential)
    potential.each.all? do |thing, times|
      case thing
      when 'cats', 'trees'
        real[thing] < times
      when 'pomeranians', 'goldfish'
        real[thing] > times
      else
        real[thing] == times
      end
    end
  end
end
