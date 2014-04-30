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
      hand = hand_from_string("TC Jc 8c 7C 9C")
      expect(hand.rank).to eq(HandRanks::STRAIGHT_FLUSH)
    end

    it "identifies 4 of a kind" do
      hand = hand_from_string("9d 9C 8C 9s 9h")
      expect(hand.rank).to eq(HandRanks::FOUR_OF_A_KIND)
    end

    it "identifies full house" do
      hand = hand_from_string("9d 8c 9s 8d 9h")
      expect(hand.rank).to eq(HandRanks::FULL_HOUSE)
    end

    it "identifies flush" do
      hand = hand_from_string("TC Qc 7c 9c 8c")
      expect(hand.rank).to eq(HandRanks::FLUSH)
    end

    context "identifies straights" do
      it "ace-high" do
	hand = hand_from_string("AH QC Kc tc JC")
	expect(hand.rank).to eq(HandRanks::STRAIGHT)
      end

      it "ace-low" do
	hand = hand_from_string("AH 3c 2C 5c 4C")
	expect(hand.rank).to eq(HandRanks::STRAIGHT)
      end
    end

    it "identifies three of a kind" do
      hand = hand_from_string("AH 3C As 5D AC")
      expect(hand.rank).to eq(HandRanks::THREE_OF_A_KIND)
    end

    it "identifies two pair" do
      hand = hand_from_string("AH 3C As 5d 3S")
      expect(hand.rank).to eq(HandRanks::TWO_PAIR)
    end

    it "identifies pair" do
      hand = hand_from_string("AH 3C As 5d 4S")
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

def hand_from_string(card_string)
  cards = []
  card_string.split(" ").each do |card|
    cards << Card.new(card)
  end
  Hand.new(cards: cards)
end


