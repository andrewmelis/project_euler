class Hand
  include Comparable
  
  attr_reader :cards, :player_number

  def initialize(cards:, player_number:)
    @player_number = player_number
    @cards = cards
  end

  def <=>(anOther)
    rank <=> anOther.rank
  end

  def to_s
    "player #{player_number}: #{@cards.each {|card| card.to_s}}"
  end

  def inspect
    to_s
  end


end
