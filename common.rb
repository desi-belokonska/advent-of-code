class Common
  def initialize
    @year = Options.instance[:year] || Time.now.year
    @test = Options.instance[:test] || false
  end

  def lines(&block)
    @lines ||= proc {
      f = File.new(input_file_name, autoclose: true)
      arr = f.readlines(chomp: true)

      block_given? ? arr.map(&block) : arr
    }.call
  rescue Errno::ENOENT
    puts "The file for day #{day} does not exist in #{@year}/input/"

    exit 1
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
    @test
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
