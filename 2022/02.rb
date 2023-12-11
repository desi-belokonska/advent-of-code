require './common'

# Day 2 of Advent of code
class Day02 < Common
  RESULT = {
    'r' => {
      'r' => 'd',
      'p' => 'w',
      's' => 'l'
    },
    'p' => {
      'r' => 'l',
      'p' => 'd',
      's' => 'w'
    },
    's' => {
      'r' => 'w',
      'p' => 'l',
      's' => 'd'
    }
  }.freeze

  SHAPE_SCORE = {
    'r' => 1,
    'p' => 2,
    's' => 3
  }.freeze

  RESULT_SCORE = {
    'w' => 6,
    'd' => 3,
    'l' => 0
  }.freeze

  SHAPE_NEEDED = RESULT.transform_values(&:invert).freeze

  def input
    lines do |line|
      line.split(' ')
          .map do |c|
        c
          .gsub(/[A,X]/, 'r')
          .gsub(/[B,Y]/, 'p')
          .gsub(/[C,Z]/, 's')
          .gsub(/X/, 'l')
          .gsub(/Y/, 'd')
          .gsub(/Z/, 'w')
      end
    end
  end

  def input2
    lines do |line|
      line.split(' ')
          .map do |c|
        c
          .gsub(/A/, 'r')
          .gsub(/B/, 'p')
          .gsub(/C/, 's')
          .gsub(/X/, 'l')
          .gsub(/Y/, 'd')
          .gsub(/Z/, 'w')
      end
    end
  end

  def part1
    input
      .map { |you, me| RESULT_SCORE[RESULT[you][me]] + SHAPE_SCORE[me] }
      .sum
  end

  def part2
    input2
      .map { |you, result| SHAPE_SCORE[ SHAPE_NEEDED[you][result] ] + RESULT_SCORE[result] }
      .sum
  end
end
