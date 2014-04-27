require 'spec_helper'

describe Hand do
  let(:sample_loser) {cards = []; cards << Card.new('5H') << Card.new('6H') << Card.new('5C') << Card.new('5D') << Card.new('6C') }
  let(:sample_winner) {cards = []; cards << Card.new('7H') << Card.new('8H') << Card.new('7C') << Card.new('7D') << Card.new('7C') }

  describe "#initialize" do
    it "adds each input card to hand" do
      hand = Hand.new(cards: sample_loser, player_number: 2)
      expect(hand.cards.size).to eq(5)
    end
  end

  describe "#<=>" do
    it "compares hand ranks" do
      pending "implement rank comparison"
      loser = Hand.new(cards: sample_loser, player_number: 1)
      winner = Hand.new(cards: sample_winner, player_number: 2)

      expect(loser < winner).to be_true
    end
  end



end

