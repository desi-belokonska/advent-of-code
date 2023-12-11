class Common
  def initialize(year)
    @year = year
  end

  def lines(&block)
    @lines ||= proc {
      f = File.new(input_file_name, autoclose: true)
      arr = f.readlines(chomp: true)

      block_given? ? arr.map(&block) : arr
    }.call
  end

  def nums
    lines.map(&:to_i)
  end

  def solution
    part == 2 ? part2 : part1
  end

  protected

  def part1; end

  def part2; end

  def test?
    ARGV[2] == 'test'
  end

  private

  def input_file_name
    "#{@year}/input/input#{day}#{'-test' if test?}.txt"
  end

  def day
    self.class.name.delete_prefix('Day')
  end

  def part
    ARGV[1]&.to_i || 1
  end
end
