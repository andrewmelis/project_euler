require 'spec_helper'

describe Hand do
  let(:sample_loser) {cards = []; cards << Card.new('5H') << Card.new('6H') << Card.new('5C') << Card.new('5D') << Card.new('6C') }
  let(:sample_winner) {cards = []; cards << Card.new('7H') << Card.new('8H') << Card.new('7C') << Card.new('7D') << Card.new('7C') }

  describe "#initialize" do
    it "adds each input card to hand" do
      hand = Hand.new(cards: sample_loser, player_number: 2)
      expect(hand.cards.size).to eq(5)
    end

    it "defaults player number to -1" do
      hand = Hand.new(cards: sample_loser)
      expect(hand.player_number).to eq(-1)
    end

  end

  describe "#evaluate" do
    let(:cards) {cards = []}
    it "identifies straight flush" do
      cards << Card.new("JC")
      cards << Card.new("TC")
      cards << Card.new("9C")
      cards << Card.new("8C")
      cards << Card.new("7C")
      hand = Hand.new(cards: cards)

      expect(hand.rank).to eq(HandRanks::STRAIGHT_FLUSH)
    end

    it "identifies 4 of a kind" do
      cards << Card.new("9d")
      cards << Card.new("9C")
      cards << Card.new("9s")
      cards << Card.new("8C")
      cards << Card.new("9h")
      hand = Hand.new(cards: cards)

      expect(hand.rank).to eq(HandRanks::FOUR_OF_A_KIND)
    end

    it "identifies full house" do
      cards << Card.new("9d")
      cards << Card.new("8C")
      cards << Card.new("9s")
      cards << Card.new("8d")
      cards << Card.new("9h")
      hand = Hand.new(cards: cards)

      expect(hand.rank).to eq(HandRanks::FULL_HOUSE)
    end

    it "identifies flush" do
      cards << Card.new("QC")
      cards << Card.new("TC")
      cards << Card.new("9C")
      cards << Card.new("8C")
      cards << Card.new("7C")
      hand = Hand.new(cards: cards)

      expect(hand.rank).to eq(HandRanks::FLUSH)
    end

    context "identifies straights" do
      it "ace-high" do
	cards << Card.new("AH")
	cards << Card.new("KC")
	cards << Card.new("QC")
	cards << Card.new("JC")
	cards << Card.new("TC")

	hand = Hand.new(cards: cards)

	expect(hand.rank).to eq(HandRanks::STRAIGHT)
      end
      it "ace-low" do
	cards << Card.new("AH")
	cards << Card.new("2C")
	cards << Card.new("3C")
	cards << Card.new("4C")
	cards << Card.new("5C")

	hand = Hand.new(cards: cards)

	expect(hand.rank).to eq(HandRanks::STRAIGHT)
      end
    end

    it "identifies three of a kind" do
      cards << Card.new("AH")
      cards << Card.new("3C")
      cards << Card.new("As")
      cards << Card.new("5D")
      cards << Card.new("AC")

      hand = Hand.new(cards: cards)

      expect(hand.rank).to eq(HandRanks::THREE_OF_A_KIND)
    end

    it "identifies two pair" do
      cards << Card.new("AH")
      cards << Card.new("3C")
      cards << Card.new("As")
      cards << Card.new("5D")
      cards << Card.new("3s")

      hand = Hand.new(cards: cards)

      expect(hand.rank).to eq(HandRanks::TWO_PAIR)
    end

    it "identifies pair" do
      cards << Card.new("AH")
      cards << Card.new("3C")
      cards << Card.new("As")
      cards << Card.new("5D")
      cards << Card.new("4s")

      hand = Hand.new(cards: cards)

      expect(hand.rank).to eq(HandRanks::PAIR)
    end
  end

  describe "#<=>" do
    it "compares hand ranks" do
      loser = Hand.new(cards: sample_loser, player_number: 1)
      winner = Hand.new(cards: sample_winner, player_number: 2)

      expect(loser < winner).to be_true
    end

    it "breaks ties properly" do
      pending "implement tiebreak logic"
    end
  end




end

