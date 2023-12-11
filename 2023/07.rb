require_relative '../common'

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

  def part2
    lines
      .map(&:split)
      .sort { |a, b| compare_hands(a[0], b[0], with_joker: true) }
      .each_with_index.map do |elem, rank|
        _hand, bid = elem
        [bid.to_i, rank + 1]
      end
      .sum do |bid, rank|
        bid * rank
      end
  end

  private

  def compare_hands(hand_a, hand_b, with_joker: false)
    a_type = classify_hand(hand_a, with_joker: with_joker)
    b_type = classify_hand(hand_b, with_joker: with_joker)

    std_ord = STANDARD_ORDER[a_type] <=> STANDARD_ORDER[b_type]

    return std_ord unless std_ord.zero?

    second_ordering(hand_a, hand_b, with_joker: with_joker)
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
  }

  def second_ordering(hand_a, hand_b, with_joker: false)
    CARD_ORDER['J'] = 0 if with_joker

    hand_a.chars.zip(hand_b.chars).each do |a, b|
      next if (CARD_ORDER[a] <=> CARD_ORDER[b]).zero?

      return CARD_ORDER[a] <=> CARD_ORDER[b]
    end

    0
  end

  # five_of_a_kind
  # AAAAA (1)
  # AAAAJ (2)
  # AAAJJ (2)
  # four_of_a_kind
  # AAAA2 (2)
  # AAAJ2 (3)
  # full_house
  # AAA22 (2)
  # AA22J (3)
  # three_of_a_kind
  # AAA23 (3)
  # AAJ23 (4)
  # AJJ23 (4)
  # two_pair
  # AA223 (3)
  # one_pair
  # AA234 (4)
  # AJ234 (5)
  # high_card
  # A2345 (5)

  def classify_hand(hand, with_joker: false)
    tally = hand.chars.tally

    num_jokers = with_joker && tally.keys.include?('J') ? tally['J'] : 0

    with_joker = false if num_jokers.zero?

    return :five_of_a_kind if tally.length == 1

    case tally.length
    when 2
      return :five_of_a_kind if tally.values.include?(5 - num_jokers) && with_joker
      return :four_of_a_kind if tally.values.include?(4)

      :full_house
    when 3
      return :four_of_a_kind if tally.values.include?(4 - num_jokers) && with_joker
      return :full_house if tally.values.include?(3 - num_jokers) && with_joker ## might be wrong
      return :three_of_a_kind if tally.values.include?(3)

      :two_pair
    when 4
      return :three_of_a_kind if tally.values.include?(3 - num_jokers) && with_joker

      :one_pair
    else
      return :one_pair if tally.values.include?(2 - num_jokers) && with_joker

      :high_card
    end
  end
end
