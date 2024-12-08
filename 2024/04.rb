require_relative '../common'

class Day04 < Common
  def part1
    horizontals + verticals + diagonals
  end

  def part2
    rows.times.sum do |r|
      cols.times.count do |c|
        xmas?(r, c) if lines[r][c] == 'A'
      end
    end
  end

  private

  def rows
    @rows ||= lines.length
  end

  def cols
    @cols ||= lines[0].length
  end

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

  def xmas?(r, c)
    return false if [r + 1, r, r - 1].any? { |n| n < 0 || n >= rows }
    return false if [c + 1, c, c - 1].any? { |n| n < 0 || n >= cols }

    diag_a = [lines[r - 1][c - 1], lines[r][c], lines[r + 1][c + 1]].join
    diag_b = [lines[r - 1][c + 1], lines[r][c], lines[r + 1][c - 1]].join

    %w[MAS SAM].include?(diag_a) && %w[MAS SAM].include?(diag_b)
  end
end
