require 'pry'
class Deliverybot
  attr_reader :command_nums, :starting_point, :coordinates, :grid
  attr_accessor :current_position, :directions
  def initialize(command)
    @command_nums = command.scan(/\d/)
    @starting_point = {x: 0, y: 0}
    @coordinates = parse_command
    @grid = parse_grid
    @current_position = @starting_point
    @directions = []
    validate_grid(@grid)
    validate_command_nums(@command_nums)
  end

  def generate_directions
    coordinates.each do |coords|
      if current_position[:x] == coords[:x] && current_position[:y] == coords[:y]
        directions << "D"
      else
        next_stop(coords)
      end
    end
    directions.join('')
  end

  private

  def validate_grid(grid)
    if (grid[:width] < 1 || grid[:height] < 1) 
      raise ArgumentError, 'First 2 digits of your command string should be greater than 0 to specify dimenstions of your grid'
    end
  end

  def validate_command_nums(nums)
    if nums.length % 2 != 0
      raise ArgumentError, 'Your command must contain even number of digits to be parsed as coordinates'
    end

    beyond_grid = nums.drop(2).select do |n|
      n.to_i > @grid[:width] || n.to_i > @grid[:height]
    end

    if beyond_grid.length > 0
      raise ArgumentError, 'Coordinates in your command string should not be greater than any of the grid axes'
    end
  end

  def next_stop(coords)
    if current_position[:x] < coords[:x]
      (coords[:x] - current_position[:x]).times do |i|
        self.directions << "E"
        current_position[:x] = current_position[:x] + 1
      end
    elsif current_position[:x] > coords[:x]
      (current_position[:x] - coords[:x]).times do |i|
        self.directions << "W"
        current_position[:x] = current_position[:x] - 1
      end
    end

    if current_position[:y] < coords[:y]
      (coords[:y] - current_position[:y]).times do |i|
        self.directions << "N"
        current_position[:y] = current_position[:y] + 1
      end
    elsif current_position[:y] > coords[:y]
      (current_position[:y] - coords[:y]).times do |i|
        self.directions << "S"
        current_position[:y] = current_position[:y] - 1
      end
    end

    if current_position[:x] == coords[:x] && current_position[:y] == coords[:y]
      directions << "D"
    end
  end

  def parse_command
    nums = command_nums.drop(2)
    ar = []
    nums.each_slice(2) do |slice|
      ar << {x: slice[0].to_i, y: slice[1].to_i}
    end
    ar
  end

  def parse_grid
    grid_ar = command_nums.first(2)
    @grid = {width: grid_ar[0].to_i, height: grid_ar[1].to_i}
  end
end