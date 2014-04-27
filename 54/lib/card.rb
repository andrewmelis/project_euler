class Card

  attr_reader :rank, :suit

  def initialize(card_string)
    @rank = card_string[0]
    @suit = card_string[1]
  end

  def to_s
    rank+suit
  end

  def inspect
    to_s
  end

end
