require './common'

# Day 13 of Advent of code
class Day13 < Common
  def part1
    pairs.each_with_index.map do |pair, i|
      packets_ordered?(*pair) ? i + 1 : 0
    end.sum
  end

  def part2
    packets_with_distress = packets.concat([[[2]], [[6]]])
    sorted = packets_with_distress.sort { |fst, snd| packets_ordered?(fst, snd) ? -1 : 1 }
    sorted.each_with_index.map { |packet, i| i + 1 if [[[2]], [[6]]].include?(packet) }.compact.reduce(&:*)
  end

  private

  def pairs
    @pairs ||= lines
               .map { |line| eval line }
               .slice_when { |arr| arr.nil? }
               .map(&:compact)
  end

  def packets
    @packets ||= lines.map { |line| eval line }.compact
  end

  # -> boolean | nil
  # true => ordered if fst < snd
  # false => unordered if fst > snd
  # nil => no conclusion
  def packets_ordered?(fst, snd)
    if fst.is_a?(Integer) && snd.is_a?(Integer)
      return false if fst > snd
      return true if fst < snd

      nil
    elsif fst.is_a?(Array) && snd.is_a?(Array)
      fst.zip(snd).each do |fst_el, snd_el|
        ordered = packets_ordered?(fst_el, snd_el)
        return ordered unless ordered.nil?
      end

      return true if fst.length < snd.length
      return false if fst.length > snd.length
    elsif [fst, snd].one? { |val| val.is_a?(Integer) }
      int_index = [fst, snd].find_index { |val| val.is_a?(Integer) }
      if int_index.zero?
        packets_ordered?([fst], snd)
      else
        packets_ordered?(fst, [snd])
      end
    end
  end
end
