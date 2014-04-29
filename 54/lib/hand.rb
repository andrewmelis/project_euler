require 'hand_ranks'

class Hand
  include Comparable
  include HandRanks

  attr_reader :cards, :player_number

  def initialize(cards:, player_number:-1)
    @player_number = player_number
    @cards = cards
  end

  def <=>(anOther)
    rank <=> anOther.rank
  end

  def rank
    return STRAIGHT_FLUSH if straight_flush?
    return FOUR_OF_A_KIND if four_of_a_kind?
    #return FULL_HOUSE	  if full_house?
    return FLUSH if flush?
    return STRAIGHT if straight?

  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?

  end

  def flush?
    if @cards.all? {|card| card.club?} 
      return true
    elsif @cards.all? {|card| card.diamond?} 
      return true
    elsif @cards.all? {|card| card.heart?}   
      return true
    elsif @cards.all? {|card| card.spade?} 
      return true
    else false
    end
  end

  def straight?
    if @cards.sort.each_cons(2).all? {|x,y| y.rank == x.rank+1}
      return true
    elsif contains_ace?
      return @cards.sort == [2,3,4,5,Card::A]
    else false
    end
  end

  def contains_ace?
    @cards.select{ |card| card.rank.eql?(Card::A) }.size > 0
  end

  def to_s
    "player #{player_number}: #{@cards.each {|card| card.to_s}}"
  end

  def inspect
    to_s
  end

end
