require './deliverybot.rb'
require 'spec_helper'
describe Deliverybot do
  string = "5x5 (0, 0) (1, 3) (4,4) (4, 2) (4, 2) (0, 1) (3, 2) (2, 3) (4, 1)"
  string_two = "5x5 (0, 0) (1, 3) (4,4)"
  string_three = "Hello World"
  command_numbers = ["5", "5", "0", "0", "1", "3", "4", "4", "4", "2", "4", "2", "0", "1", "3", "2", "2", "3", "4", "1"]
  let(:bot) { Deliverybot.new(string) }
  let(:bot_two) { Deliverybot.new(string_two) }
  context "#initialize" do
    it "instantiates with a string command passed as an argument" do
      expect(bot.command_nums).to eq(command_numbers)
    end

    it "instantiates with a hash with grid settings" do
      expect(bot.grid).to eq({width: 5, height: 5})
    end

    it "creates an array of hash coordinates for each command" do
      coordinates = [
        {:x=>0, :y=>0},
        {:x=>1, :y=>3},
        {:x=>4, :y=>4},
        {:x=>4, :y=>2},
        {:x=>4, :y=>2},
        {:x=>0, :y=>1},
        {:x=>3, :y=>2},
        {:x=>2, :y=>3},
        {:x=>4, :y=>1}
      ]
      expect(bot.coordinates).to eq coordinates
    end

    it "raises Argument Error if argument does not have valid grid digits in the string" do
      expect{Deliverybot.new(string_three)}.to raise_error(ArgumentError,
       'First 2 digits of your command string should be greater than 0 to specify dimenstions of your grid')
    end

    it "raises Argument Error if argument does not have string that contains even number of digits to treat them as coordinates" do
      expect{Deliverybot.new("5x5 (3)")}.to raise_error(ArgumentError,
        'Your command must contain even number of digits to be parsed as coordinates')
    end

    it "raises Argument Error if argment contains coordinates that are greater than its requested grid" do
      expect{Deliverybot.new("5x5 (3, 7)")}.to raise_error(ArgumentError, 'Coordinates in your command string should not be greater than any of the grid axes')
    end
  end

  context "#generate_directions" do
    it "generates currect directions" do
      exptected_dirs = 'DENNNDEEENDSSDDWWWWSDEEENDWNDEESSD'
      expect(bot.generate_directions).to eq (exptected_dirs)
    end

    it "generates currect directions two" do
      exptected_dirs_two = 'DENNNDEEEND'
      expect(bot_two.generate_directions).to eq (exptected_dirs_two)
    end
  end
end