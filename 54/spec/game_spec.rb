require 'spec_helper'

describe Game do
  let(:five_cards) {cards = []; cards << Card.new('5H') << Card.new('6H') << Card.new('5C') << Card.new('5D') << Card.new('6C') }
  let(:ten_cards) {cards = five_cards; cards << Card.new('7H') << Card.new('8H') << Card.new('7C') << Card.new('7D') << Card.new('7C') }

  describe "#initialize" do
    context "makes one hand for every five cards passed in" do

      context "five cards" do
	let(:game) {game = Game.new(five_cards)}

	it "makes one hand" do 
	  expect(game.hands.size).to eq(1)
	end

	it "correctly numbers the hand" do
	  player1 = game.hands[0]
	  expect(player1.player_number).to eq(1)
	end
      end

      context "10 cards" do
	let(:game) {game = Game.new(ten_cards)}

	it "makes two hands" do
	  expect(game.hands.size).to eq(2)
	end

	it "correctly numbers hands" do
	  player1 = game.hands[0]
	  player2 = game.hands[1]

	  expect(player1.player_number).to eq(1)
	  expect(player2.player_number).to eq(2)
	end
      end
    end

    context "error cases" do
      context "nil case" do
	it "raises an error" do 
	  expect {Game.new(nil)}.to raise_error(ArgumentError, 'incompatible number of cards')
	end
      end

      context "no cards" do
	it "raises an error" do 
	  cards = []
	  expect {Game.new(cards)}.to raise_error(ArgumentError, 'incompatible number of cards')
	end
      end

      context "11 cards" do
	it "raises an error" do 
	  cards = ten_cards
	  cards << Card.new('AS')
	  expect {Game.new(cards)}.to raise_error(ArgumentError, 'incompatible number of cards')
	end
      end
    end
  end

  describe "#winner?" do
    context "valid game" do
      it "returns the player number with the greatest ranking hand" do
	pending "implement hand comparable"
	game = Game.new(ten_cards)
	expect(game.winner?).to eq(2)
      end
    end

    context "invalid game" do
      context "single player" do
	it "raises an error" do
	  game = Game.new(five_cards)
	  expect {game.winner?}.to raise_error(RuntimeError, "only 1 player in game")
	end
      end
    end

  end

end

