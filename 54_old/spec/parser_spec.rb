require 'spec_helper'
require 'stringio'
require 'game'

describe Parser do
  let (:test_file_contents) {"2s 3s 4s 5s 6s 7s 8s 9s Ts Js"}
  let (:test_result) {["2s", "3s", "4s", "5s", "6s", "7s", "8s", "9s", "Ts", "Js"]}

  before(:each) do
    file = double("StringIO", :readlines => test_file_contents)
    @parser = Parser.new(file)
  end

  describe "#initialize" do
    it "reads an input file and stores a result" do
      expect(@parser.parsed_file).to eq(test_result)
    end
  end

  describe "#games" do
    it "splits lines into games" do
      test_game = Game.new(test_result)
      games = [test_game]
      expect(@parser.games).to eq(games)
    end

  end


end
