require_relative './hand_ranks'

module HandComparable
  include Comparable
  include HandRanks

  def <=>(anOther)
    return rank <=> anOther.rank if rank != anOther.rank
    break_ties(anOther)
  end

  def break_ties(anOther)
    case rank
    when STRAIGHT_FLUSH
      break_straight_flush(anOther)
    when FOUR_OF_A_KIND
      break_four_of_a_kind(anOther)
    when FULL_HOUSE
      break_full_house(anOther)
    when FLUSH
      break_flush(anOther)
    when STRAIGHT
      break_straight(anOther)
    when THREE_OF_A_KIND
      break_three_of_a_kind(anOther)
    when TWO_PAIR
      break_two_pair(anOther)
    when PAIR
      break_pairs(anOther)
    when HIGH_CARD
      break_high_card(anOther)
    end
  end

  def break_straight_flush(anOther)
    break_high_card(anOther)
  end

  def break_four_of_a_kind(anOther)
    myCard = get_quad_rank(@cards)
    otherCard = get_quad_rank(anOther.cards)
    myCard <=> otherCard
  end

  def get_quad_rank(cards)
    cards.detect {|card| cards.rindex(card) != cards.index(card)}
  end

  def break_full_house(anOther)
    break_three_of_a_kind(anOther)
  end

  def break_flush(anOther)
    break_high_card(anOther)
  end

  def break_straight(anOther)
    break_high_card(anOther)
  end
  
  def break_three_of_a_kind(anOther)
    myCard = get_trips_rank(@cards) 
    otherCard = get_trips_rank(anOther.cards)
    myCard <=> otherCard
  end

  def get_trips_rank(cards)
    ranks = cards.sort.collect{ |card| card.rank}
    ranks.each_cons(3) do |set_of_3| 
      return set_of_3.uniq if set_of_3.uniq.size == 1
    end
  end

  def break_two_pair(anOther)
    break_pairs(anOther)
  end

  def break_pairs(anOther)
    myPairs = get_pairs(@cards)
    otherPairs = get_pairs(anOther.cards)

    pairs_comp = compare_eql_size_lists(myPairs, otherPairs)
    return pairs_comp if pairs_comp != 0

    myCardsMinusPairs = @cards - myPairs
    otherCardsMinusPairs = anOther.cards - otherPairs

    compare_eql_size_lists(myCardsMinusPairs, otherCardsMinusPairs)
  end

  def get_pairs(cards)
    cards.select {|card| cards.count(card) > 1}.uniq.sort
  end

  def break_high_card(anOther)
    compare_eql_size_lists(@cards, anOther.cards)
  end

  def compare_eql_size_lists(list1,list2)
    list2 = list2.sort.reverse
    list1.sort.reverse.each_with_index do |item, index|
      if (item <=> list2[index]) != 0
	return item <=> list2[index]
      end
    end
    0
  end

end
