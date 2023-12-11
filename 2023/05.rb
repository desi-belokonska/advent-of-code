require_relative '../common'

# Day 5 of Advent of code
class Day05 < Common
  def part1
    seeds
      .map(&method(:seed_to_soil))
      .map(&method(:soil_to_fertilizer))
      .map(&method(:fertilizer_to_water))
      .map(&method(:water_to_light))
      .map(&method(:light_to_temperature))
      .map(&method(:temperature_to_humidity))
      .map(&method(:humidity_to_location))
      .min
  end

  def part2
    map_source_to_destination_ranges(seed_ranges, seed_to_soil_map)
      .then { |ranges| map_source_to_destination_ranges(ranges, soil_to_fertilizer_map) }
      .then { |ranges| map_source_to_destination_ranges(ranges, fertilizer_to_water_map) }
      .then { |ranges| map_source_to_destination_ranges(ranges, water_to_light_map) }
      .then { |ranges| map_source_to_destination_ranges(ranges, light_to_temperature_map) }
      .then { |ranges| map_source_to_destination_ranges(ranges, temperature_to_humidity_map) }
      .then { |ranges| map_source_to_destination_ranges(ranges, humidity_to_location_map) }
      .min_by(&:min).min
  end

  private

  def seeds
    @seeds ||= lines.first.scan(/\d+/).map(&:to_i)
  end

  def seed_ranges
    @seed_ranges ||= seeds.each_slice(2).map do |start, range_length|
      (start...start + range_length)
    end
  end

  # seed-to-soil map
  def seed_to_soil_map
    @seed_to_soil_map ||= process_map(lines, 'seed-to-soil map')
  end

  def seed_to_soil(seed)
    find_in_map(seed, seed_to_soil_map)
  end

  # soil-to-fertilizer map
  def soil_to_fertilizer_map
    @soil_to_fertilizer_map ||= process_map(lines, 'soil-to-fertilizer map')
  end

  def soil_to_fertilizer(soil)
    find_in_map(soil, soil_to_fertilizer_map)
  end

  # fertilizer-to-water map
  def fertilizer_to_water_map
    @fertilizer_to_water_map ||= process_map(lines, 'fertilizer-to-water map')
  end

  def fertilizer_to_water(fertilizer)
    find_in_map(fertilizer, fertilizer_to_water_map)
  end

  # water-to-light map
  def water_to_light_map
    @water_to_light_map ||= process_map(lines, 'water-to-light map')
  end

  def water_to_light(water)
    find_in_map(water, water_to_light_map)
  end

  # light-to-temperature map
  def light_to_temperature_map
    @light_to_temperature_map ||= process_map(lines, 'light-to-temperature map')
  end

  def light_to_temperature(light)
    find_in_map(light, light_to_temperature_map)
  end

  # temperature-to-humidity map
  def temperature_to_humidity_map
    @temperature_to_humidity_map ||= process_map(lines, 'temperature-to-humidity map')
  end

  def temperature_to_humidity(temperature)
    find_in_map(temperature, temperature_to_humidity_map)
  end

  # humidity-to-location map
  def humidity_to_location_map
    @humidity_to_location_map ||= process_map(lines, 'humidity-to-location map')
  end

  def humidity_to_location(humidity)
    find_in_map(humidity, humidity_to_location_map)
  end

  def find_in_map(num, ranges)
    ranges.each do |src, dst|
      return dst.min + (num - src.min) if src.include?(num)
    end

    num
  end

  def process_map(lines, map_name)
    rest = lines.drop_while { |line| !line.match?(map_name) }
    map_lines = rest.drop(1).take_while { |line| !line.empty? }
    map_lines
      .each_with_object({}) do |line, result|
        dest_start, source_start, range_length = line.scan(/\d+/).map(&:to_i)
        result[source_start...(source_start + range_length)] = (dest_start...(dest_start + range_length))
      end
  end

  def map_source_to_destination_ranges(source_ranges, destination_map)
    result = []
    source_ranges.each do |src|
      destination_map.each_with_index do |(orig_src, dst), i|
        if (overlap = range_overlap(src, orig_src))
          result << ((overlap.min - orig_src.min + dst.min)..(overlap.max - orig_src.max + dst.max))
          break if overlap.size == src.size

          src = if overlap.max < src.max
                  ((overlap.max + 1)..src.max)
                else
                  ((src.min)..(overlap.min - 1))
                end

        elsif i == destination_map.size - 1
          result << src
        end
      end
    end
    result
  end

  def range_overlap(range1, range2)
    return nil if range1.max < range2.begin || range2.max < range1.begin

    [range1.begin, range2.begin].max..[range1.max, range2.max].min
  end
end
