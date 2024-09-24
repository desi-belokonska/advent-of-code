require_relative '../common'
require 'set'

class Day13 < Common
  def part1
    happiness = Hash.new { |hash, key| hash[key] = 0 }
    names = Set.new

    lines.each do |line|
      match = line.match(/(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)./)

      fst = match[1]
      snd = match[4]
      units = match[2] == 'gain' ? match[3].to_i : - match[3].to_i

      happiness[[fst, snd].to_set] += units
      names.merge([fst, snd])
    end

    names.to_a.permutation.map do |ordering|
      sum = ordering.each_cons(2).sum do |pair|
        happiness[pair.to_set]
      end
      sum + happiness[[ordering.first, ordering.last].to_set]
    end.max
  end
end
