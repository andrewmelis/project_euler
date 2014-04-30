require_relative './hand_comparable'

class Hand
  include HandComparable

  attr_reader :cards, :player_number

  def initialize(cards:, player_number:-1)
    @player_number = player_number
    validate(cards)
    @cards = cards
  end

  def validate(cards)

  end

  def rank
    return STRAIGHT_FLUSH  if straight_flush?
    return FOUR_OF_A_KIND  if four_of_a_kind?
    return FULL_HOUSE	   if full_house?
    return FLUSH	   if flush?
    return STRAIGHT	   if straight?
    return THREE_OF_A_KIND if three_of_a_kind?
    return TWO_PAIR	   if two_pair?
    return PAIR		   if pair?
    return HIGH_CARD  
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    ranks = @cards.sort.collect{ |card| card.rank}
    ranks.each_cons(4).any? { |set_of_4| set_of_4.uniq.size == 1}
  end
  
  def full_house?
    ranks = @cards.sort.collect{ |card| card.rank}
    if three_of_a_kind? && ranks.uniq!.size == 2
      true
    else false
    end
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

  def three_of_a_kind?
    ranks = @cards.sort.collect{ |card| card.rank}
    ranks.each_cons(3).any? { |set_of_3| set_of_3.uniq.size == 1}
  end

  def two_pair?
    ranks = @cards.sort.collect{ |card| card.rank}
    if pair? && ranks.uniq!.size == 3
      true
    else false
    end
  end

  def pair?
    ranks = @cards.sort.collect{ |card| card.rank}
    ranks.each_cons(2).any? { |set_of_2| set_of_2.uniq.size == 1}
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
