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
    #return FOUR_OF_A_KIND if four_of_a_kind?
    #return FULL_HOUSE	  if full_house?
    return FLUSH if flush?
    return STRAIGHT if straight?

  end

  def straight_flush?
    flush? && straight?
  end

  def flush?
    if @cards.all? {|card| card.club?} 
      puts "clubs"
      return true
    elsif @cards.all? {|card| card.diamond?} 
      puts "diamond"
      return true
    elsif @cards.all? {|card| card.heart?}   
      puts "heart"
      return true
    elsif @cards.all? {|card| card.spade?} 
      puts "spade"
      return true
    else false
    end
  end

  def straight?
    @cards.sort.each_cons(2).all? {|x,y| y.rank == x.rank+1}
  end

  def to_s
    "player #{player_number}: #{@cards.each {|card| card.to_s}}"
  end

  def inspect
    to_s
  end

end
