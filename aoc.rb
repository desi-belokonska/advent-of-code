#!/usr/bin/env ruby

day = ARGV[0]
file = "~/advent-of-code-2023/#{day}.rb"

$LOAD_PATH << '~/advent-of-code-2023/'

require(file)

p Object.const_get("Day#{day}").new.solution
