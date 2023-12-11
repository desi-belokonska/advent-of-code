require './common'

# Day 7 of Advent of code
class Day07 < Common
  def part1
    folders, = folders_and_filesystem
    folders.map(&:size).select { |s| s < 100_000 }.sum
  end

  def part2
    folders, filesystem = folders_and_filesystem

    total_space = 70_000_000
    space_needed = 30_000_000
    space_used = filesystem.size

    space_unused = total_space - space_used

    folders.map(&:size).select { |s| s + space_unused >= space_needed }.min
  end

  private

  def folders_and_filesystem
    filesystem = Folder.new('/')
    folders = []
    current = filesystem

    lines.slice_before { |line| line.start_with?('$') }.each do |cmd_output|
      command = cmd_output.first
      output = cmd_output.drop(1)

      case command
      when /\$ cd (\\)/
        current = filesystem
      when /\$ cd (\.\.)/
        current = current.parent
      when /\$ cd ([a-z]+)/
        current = current.children[Regexp.last_match(1)]
      when /\$ ls/
        output.each do |line|
          case line
          when /(\d+) ([\w.]+)/
            _, size, name = Regexp.last_match.to_a
            current.add_file(name, size.to_i)
          when /dir (\w+)/
            _, name = Regexp.last_match.to_a
            folders << current.add_folder(name)
          end
        end
      end
    end
    [folders, filesystem]
  end

  # Represents a folder
  class Folder
    attr_reader :name, :children, :parent

    def initialize(name, parent: nil, children: {})
      @name = name
      @children = children
      @parent = parent
    end

    def root?
      name == '/'
    end

    def add_file(name, size)
      new_file = File.new(name, size, self)
      children[name] = new_file
      new_file
    end

    def add_folder(name)
      new_folder = Folder.new(name, parent: self)
      children[name] = new_folder
      new_folder
    end

    def inspect
      inspect_with_indent
    end

    def inspect_with_indent(indent = '')
      "#{indent}- #{name} (dir)\n" + children.values.map { |child| child.inspect_with_indent("#{indent}  ") }.join
    end

    def size
      children.values.map(&:size).sum
    end
  end

  # Represents a file
  class File
    attr_reader :name, :size, :parent

    def initialize(name, size, parent)
      @name = name
      @size = size
      @parent = parent
    end

    def inspect
      inspect_with_indent
    end

    def inspect_with_indent(indent = '')
      "#{indent}- #{name} (file, size=#{size})\n"
    end
  end
end
