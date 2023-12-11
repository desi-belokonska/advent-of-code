require 'set'
require 'ostruct'
require './common'

# Day 9 of Advent of code
class Day09 < Common
  def part1
    tail = OpenStruct.new(x: 0, y: 0)
    head = OpenStruct.new(x: 0, y: 0)
    visited = Set[tail]

    directions.each do |dir, times|
      move_head = proc do
        case dir
        when 'R'
          head.x += 1
        when 'L'
          head.x -= 1
        when 'U'
          head.y += 1
        when 'D'
          head.y -= 1
        end
      end

      times.times do
        move_head.call
        tail = move_tail(tail, head) if should_move?(tail, head)
        visited << tail
      end
    end

    visited.size
  end

  def part2
    tails = 9.times.map { OpenStruct.new(x: 0, y: 0) }
    head = OpenStruct.new(x: 0, y: 0)
    visited = Set[tails.last]

    directions.each do |dir, times|
      move_head = proc do
        case dir
        when 'R'
          head.x += 1
        when 'L'
          head.x -= 1
        when 'U'
          head.y += 1
        when 'D'
          head.y -= 1
        end
      end

      times.times do
        move_head.call
        new_head = head
        tails.each_with_index do |tail, i|
          new_tail = move_tail(tail, new_head) if should_move?(tail, new_head)
          tails[i] = new_tail if new_tail
          new_head = tails[i]
        end
        visited << tails.last
      end
    end

    visited.size
  end

  private

  def directions
    @directions ||= lines.map do |line|
      dir, times = line.split(' ')
      [dir, times.to_i]
    end
  end

  def should_move?(tail, head)
    (head.x - tail.x).abs > 1 || (head.y - tail.y).abs > 1
  end

  def move_tail(orig_tail, head)
    tail = orig_tail.dup
    if on_same_row?(tail, head)
      tail.x += head.x > tail.x ? 1 : -1
    elsif on_same_col?(tail, head)
      tail.y += head.y > tail.y ? 1 : -1
    else
      tail.x += head.x > tail.x ? 1 : -1
      tail.y += head.y > tail.y ? 1 : -1
    end
    tail
  end

  def on_same_row?(tail, head)
    tail.y == head.y
  end

  def on_same_col?(tail, head)
    tail.x == head.x
  end
end
