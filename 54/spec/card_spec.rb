require 'spec_helper'

describe Card do

  context "construction" do

    describe "#parse_rank" do
      it "parses numbers correctly" do
	card = Card.new("9s")
	expect(card.rank).to eq(9)
      end

      it "parses Ace correctly" do
	card = Card.new("As")
	expect(card.rank).to eq(Card::A)
      end

      it "parses King correctly" do
	card = Card.new("Ks")
	expect(card.rank).to eq(Card::K)
      end

      it "parses Queen correctly" do
	card = Card.new("Qs")
	expect(card.rank).to eq(Card::Q)
      end

      it "parses (lowercase) Jack correctly" do
	card = Card.new("js")
	expect(card.rank).to eq(Card::J)
      end

      it "parses (lowercase) Ten correctly" do
	card = Card.new("ts")
	expect(card.rank).to eq(Card::T)
      end

      context "error cases" do

	it "raises an error when given an invalid character" do
	  card_string = "xx"
	  expect {Card.new(card_string)}.to raise_error(NameError)
	end

	it "raises an error when given an invalid number" do
	  card_string = "1x"
	  expect {Card.new(card_string)}.to raise_error(NameError)
	end
      end
    end

    describe "#parse_suit" do
      it "parses clubs correctly" do
	expect(Card.new("9C").suit).to eq("c")
      end

      it "parses diamonds correctly" do
	expect(Card.new("9d").suit).to eq("d")
      end

      it "parses hearts correctly" do
	expect(Card.new("9H").suit).to eq("h")
      end

      it "parses spades correctly" do
	expect(Card.new("9s").suit).to eq("s")
      end


      context "error cases" do
	it "raises an error if invalid suit is input" do
	  card_string = "3x"
	  expect {Card.new(card_string)}.to raise_error(ArgumentError, "invalid suit parameter")
	end

      end
    end

    describe "#to_s" do
      it "prints out the proper string for face cards" do
	pending "figure out constant name value lookup"
	expect(Card.new("As")).to eq("As")
      end
    end

  end

end
