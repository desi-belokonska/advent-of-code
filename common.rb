class Common
  def initialize(year)
    @year = year
  end

  def lines(&block)
    f = File.new(input_file_name, autoclose: true)

    arr = f.readlines(chomp: true)
    @lines ||= if block_given?
                 arr.map(&block)
               else
                 arr
               end
  end

  def nums
    lines.map(&:to_i)
  end

  def solution
    return part1 if part == 1

    part2
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
