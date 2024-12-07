require_relative '../common'

class Day04 < Common
  def part1
    horizontals + verticals + diagonals
  end

  private

  def horizontals
    lines.sum do |line|
      horizontal = line.scan(/XMAS/).count
      horizontal_reversed = line.scan(/SAMX/).count

      horizontal + horizontal_reversed
    end
  end

  def verticals
    lines.map(&:chars).transpose.map(&:join).sum do |col|
      vertical = col.scan(/XMAS/).count
      vertical_reversed = col.scan(/SAMX/).count

      vertical + vertical_reversed
    end
  end

  def diagonals
    total = 0
    rows = lines.length
    cols = lines[0].length

    # all possible diagonals
    (0...rows + cols - 1).each do |d|
      # top-right to bottom-left
      diagonal = (0...rows).filter_map do |r|
        c = d - r
        lines[r][c] if c >= 0 && c < cols
      end.join
      total += diagonal.scan(/XMAS/).count + diagonal.scan(/SAMX/).count

      # top-left to bottom-right
      diagonal = (0...rows).filter_map do |r|
        c = cols - 1 - (d - r)
        lines[r][c] if c >= 0 && c < cols
      end.join
      total += diagonal.scan(/XMAS/).count + diagonal.scan(/SAMX/).count
    end

    total
  end
end
