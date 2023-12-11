require_relative '../common'

# Day 11 of Advent of code
class Day11 < Common
  def initialize
    super
    @global_mod = 1
  end

  def part1
    20.times do
      monkeys.each do |monkey|
        monkey.inspection(monkeys, global_mod: @global_mod)
      end
    end

    monkeys.map(&:times_inspected).sort.reverse.take(2).reduce(&:*)
  end

  def part2
    10_000.times do
      monkeys.each do |monkey|
        monkey.inspection(monkeys, no_boredom: true, global_mod: @global_mod)
      end
    end

    monkeys.map(&:times_inspected).sort.reverse.take(2).reduce(&:*)
  end

  private

  def monkeys
    @monkeys ||= proc {
      monkey_inputs = lines.slice_when do |line|
        line == ''
      end

      monkey_inputs.map do |monkey_input|
        starting_items = monkey_input[1].delete_prefix('  Starting items: ').split(', ').map(&:to_i)
        operation = eval "proc { |old| #{monkey_input[2].delete_prefix('  Operation: new = ')}}"
        divisor = monkey_input[3].delete_prefix('  Test: divisible by ').to_i
        @global_mod *= divisor
        test = proc { |item| (item % divisor).zero? }
        if_true = monkey_input[4].delete_prefix('    If true: throw to monkey ').to_i
        if_false = monkey_input[5].delete_prefix('    If false: throw to monkey ').to_i
        Monkey.new(
          operation: operation,
          test: test,
          if_true: if_true,
          if_false: if_false,
          starting_items: starting_items
        )
      end
    }.call
  end

  # It's a Monkey
  class Monkey
    attr_accessor :items
    attr_reader :times_inspected

    def initialize(operation:, test:, if_true:, if_false:, starting_items: [])
      @operation = operation
      @test = test
      @if_true = if_true
      @if_false = if_false
      @items = starting_items
      @times_inspected = 0
    end

    def inspection(monkeys, no_boredom: false, global_mod: nil)
      items.each do |item|
        worry_level = @operation.call(item)
        worry_level = worry_level % global_mod unless global_mod.nil?
        worry_level /= 3 unless no_boredom

        if @test.call(worry_level)
          monkeys[@if_true].items << worry_level
        else
          monkeys[@if_false].items << worry_level
        end

        @times_inspected += 1
      end

      items.clear
    end
  end
end
