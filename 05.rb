require './common'

# Day 5 of Advent of code
class Day05 < Common
  def part1
    # blash
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

  private

  def seeds
    @seeds ||= lines.first.scan(/\d+/).map(&:to_i)
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

  def find_in_map(source, map)
    range = map.find do |line|
      (line[:source_start]...line[:source_start] + line[:range_length]).include?(source)
    end

    return source if range.nil?

    offset = source - range[:source_start]
    range[:dest_start] + offset
  end

  def process_map(lines, map_name)
    rest = lines.drop_while { |line| !line.match?(map_name) }
    map_lines = rest.drop(1).take_while { |line| !line.empty? }
    map_lines
      .map do |line|
        dest_start, source_start, range_length = line.scan(/\d+/).map(&:to_i)
        { dest_start: dest_start, source_start: source_start, range_length: range_length }
      end
      .sort_by { |range| range[:source_start] }
  end
end
