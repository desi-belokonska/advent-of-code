require './common'

# Day 7 of Advent of code
class Day07 < Common
  def part1
    lines
      .map(&:split)
      .sort { |a, b| compare_hands(a[0], b[0]) }
      .each_with_index.map do |elem, rank|
        _hand, bid = elem
        [bid.to_i, rank + 1]
      end
      .sum do |bid, rank|
        bid * rank
      end
  end

  private

  def compare_hands(hand_a, hand_b)
    a_type = classify_hand(hand_a)
    b_type = classify_hand(hand_b)

    std_ord = STANDARD_ORDER[a_type] <=> STANDARD_ORDER[b_type]

    return std_ord unless std_ord.zero?

    second_ordering(hand_a, hand_b)
  end

  STANDARD_ORDER = {
    five_of_a_kind: 7,
    four_of_a_kind: 6,
    full_house: 5,
    three_of_a_kind: 4,
    two_pair: 3,
    one_pair: 2,
    high_card: 1
  }.freeze

  CARD_ORDER = {
    '2' => 1,
    '3' => 2,
    '4' => 3,
    '5' => 4,
    '6' => 5,
    '7' => 6,
    '8' => 7,
    '9' => 8,
    'T' => 9,
    'J' => 10,
    'Q' => 11,
    'K' => 12,
    'A' => 13
  }.freeze

  def second_ordering(hand_a, hand_b)
    hand_a.chars.zip(hand_b.chars).each do |a, b|
      next if (CARD_ORDER[a] <=> CARD_ORDER[b]).zero?

      return CARD_ORDER[a] <=> CARD_ORDER[b]
    end

    0
  end

  def classify_hand(hand)
    tally = hand.chars.tally

    return :five_of_a_kind if tally.length == 1

    case tally.length
    when 2
      return :four_of_a_kind if tally.values.include?(4)

      :full_house
    when 3
      return :three_of_a_kind if tally.values.include?(3)

      :two_pair
    when 4
      :one_pair
    else
      :high_card
    end
  end
end
