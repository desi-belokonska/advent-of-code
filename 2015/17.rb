require_relative '../common'

class Day17 < Common
  EGGNOG = 150

  def part1
    all_combinations(containers).count { |comb| comb.sum == EGGNOG }
  end

  private

  def containers
    @containers ||= lines.map(&:to_i).sort
  end

  def all_combinations(containers)
    combinations = [[]]
    containers.each do |container|
      new_combinations = combinations.map(&:clone)
      new_combinations.each do |combination|
        combination.push(container)
      end
      combinations.concat(new_combinations)
    end
    combinations
  end
end
