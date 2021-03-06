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

    it "validates no duplicate cards" do
      pending "implement dupe check"
      expect {hand_from_string("9s 8c 3s Jc 9S")}.to raise_error(ArgumentError, "invalid hand, contains duplicate card!")
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

    context "breaks ties" do
      context "straight_flush" do
	it "compares highest card" do
	  winner = hand_from_string("AH KH QH JH TH")
	  loser = hand_from_string("9c Kc QC JC Tc")
	  expect(winner > loser).to be_true
	end
	it "announces ties" do
	  player1 = hand_from_string("AH KH QH JH TH")
	  player2 = hand_from_string("As KS Qs Js Ts")
	  expect(player1 == (player2)).to be_true
	end
      end

      context "four_of_a_kind" do
	it "compares quads value" do
	  winner = hand_from_string("AH Ac As AD jh")
	  loser = hand_from_string("kH Kc Ks kD jc")
	  expect(winner > loser).to be_true
	end
      end

      context "full_house" do
	it "compares trips" do
	  winner = hand_from_string("AH Ac As jD jh")
	  loser = hand_from_string("kH Kc Ks js jc")
	  expect(winner > loser).to be_true
	end
      end

      context "flush" do
	it "compares each card until tiebreak" do
	  winner = hand_from_string("qC jc tc 9c 7c")
	  loser = hand_from_string("qH jh th 9h 6h")
	  expect(winner > loser).to be_true
	end

	it "announces ties" do
	  player1 = hand_from_string("qC jc tc 9c 7c")
	  player2 = hand_from_string("qH jh th 9h 7h")
	  expect(player1 == player2).to be_true
	end
      end

      context "straight" do
	it "compares high card" do
	  winner = hand_from_string("qC jc tc 9s 8c")
	  loser = hand_from_string("7H js th 9h 8h")
	  expect(winner > loser).to be_true
	end

	it "announces ties" do
	  player1 = hand_from_string("qC jc tc 9s 8c")
	  player2 = hand_from_string("qH js th 9h 8h")
	  expect(player1 == player2).to be_true
	end
      end

      context "three_of_a_kind" do
	it "checks trips" do
	  winner = hand_from_string("AH Ac As jD 8h")
	  loser = hand_from_string("kH Kc Ks js 7c")
	  expect(winner > loser).to be_true
	end
      end

      context "two_pair" do
	it "checks high pair first" do
	  winner = hand_from_string("As AD Ks js jc")
	  loser = hand_from_string("KH Kc 8s jD jh")
	  expect(winner > loser).to be_true
	end

	it "checks low pair second" do
	  winner = hand_from_string("As AD Ks ts Tc")
	  loser = hand_from_string("AH Ac 8s TD th")
	  expect(winner > loser).to be_true
	end

	it "breaks ties with kicker" do
	  player1 = hand_from_string("As AD Ks js jc")
	  player2 = hand_from_string("AH Ac 8s jD jh")
	  expect(player1 > player2).to be_true
	end
      end

      context "pair" do
	it "checks pair first" do
	  winner = hand_from_string("As AD Ks 2s jc")
	  loser = hand_from_string("AH Ac 8s jD 4h")
	  expect(winner > loser).to be_true
	end

	it "then compares kickers" do 
	  winner = hand_from_string("TH Tc Kd jD 4h")
	  loser = hand_from_string("Ts TD Ks 2s jc")
	  expect(winner > loser).to be_true
	end

	it "announces ties" do
	  player1 = hand_from_string("TH Tc Kd jD 4h")
	  player2 = hand_from_string("Ts TD Ks 4s jc")
	  expect(player1 == player2).to be_true
	end
      end

      context "high_card" do
	it "compares each card until tiebreak" do
	  winner = hand_from_string("TH 9c Kd jD 4h")
	  loser = hand_from_string("Ts 9D Ks 2s jc")
	  expect(winner > loser).to be_true
	end

	it "announces ties" do
	  player1 = hand_from_string("TH 9c Kd jD 4h")
	  player2 = hand_from_string("Ts 9D Ks 4s jc")
	  expect(player1 == player2).to be_true
	end

      end
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


