class Game
  attr_reader :hands

  def initialize(card_list)
    validate_init(card_list)
    construct_hands(card_list)
  end

  def validate_init(card_list)
    if card_list == nil || card_list.empty? || card_list.size % 5 != 0 
      raise ArgumentError, 'incompatible number of cards'
    end
  end

  def construct_hands(card_list)
    @hands = []
    hand_cards = []
    card_list.each_with_index do |card, index|
      hand_cards << card
      if hand_cards.size == 5
	@hands << Hand.new(cards: Array.new(hand_cards) , player_number: @hands.size+1)
	hand_cards.clear
      end
    end
  end

  def winner?
    validate_game_size
    @hands.max.player_number
  end

  def validate_game_size
    if @hands.size == 1
      raise RuntimeError, "only 1 player in game"
    end
  end

  def to_s
    hands.each {|hand| p hand}
  end

  def inspect
    to_s
  end

end

