require_relative '../common'

class Day15 < Common
  MAX = 10

  def part1
    names = ingredients.map { |ing| ing[:name] }
    n = ingredients.length

    permutations(n, 100, names).map do |perm|
      total_score(ingredients, perm)
    end.max
  end

  def part2
    names = ingredients.map { |ing| ing[:name] }
    n = ingredients.length

    permutations(n, 100, names).filter_map do |perm|
      total_score_500_cals(ingredients, perm)
    end.max
  end

  private

  def ingredients
    @ingredients ||= lines.map do |line|
      match = line.match(/(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/)

      name = match[1]
      capacity = match[2].to_i
      durability = match[3].to_i
      flavor = match[4].to_i
      texture = match[5].to_i
      calories = match[6].to_i

      { name:, capacity:, durability:, flavor:, texture:, calories: }
    end
  end

  def total_score(ingredients, tsp)
    capacity = ingredients.map { |ing| (ing[:capacity] * tsp[ing[:name]]) }.sum.clamp(0..)
    durability = ingredients.map { |ing| (ing[:durability] * tsp[ing[:name]]) }.sum.clamp(0..)
    flavor = ingredients.map { |ing| (ing[:flavor] * tsp[ing[:name]]) }.sum.clamp(0..)
    texture = ingredients.map { |ing| (ing[:texture] * tsp[ing[:name]]) }.sum.clamp(0..)

    capacity * durability * flavor * texture
  end

  def total_score_500_cals(ingredients, tsp)
    capacity = ingredients.map { |ing| (ing[:capacity] * tsp[ing[:name]]) }.sum.clamp(0..)
    durability = ingredients.map { |ing| (ing[:durability] * tsp[ing[:name]]) }.sum.clamp(0..)
    flavor = ingredients.map { |ing| (ing[:flavor] * tsp[ing[:name]]) }.sum.clamp(0..)
    texture = ingredients.map { |ing| (ing[:texture] * tsp[ing[:name]]) }.sum.clamp(0..)
    calories = ingredients.map { |ing| (ing[:calories] * tsp[ing[:name]]) }.sum.clamp(0..)

    capacity * durability * flavor * texture if calories == 500
  end

  def permutations(num, sum, names)
    case num
    when 2
      (0..sum).flat_map do |a|
        b = sum - a
        names.zip([a, b]).permutation.map(&:to_h)
      end.uniq
    when 4
      (0..sum).flat_map do |a|
        (0..sum - a).flat_map do |b|
          (0..sum - a - b).flat_map do |c|
            d = sum - a - b - c
            names.zip([a, b, c, d]).permutation.map(&:to_h)
          end
        end
      end.uniq
    else
      []
    end
  end
end
