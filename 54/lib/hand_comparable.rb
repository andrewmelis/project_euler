require 'hand_ranks'

module HandComparable
  include Comparable
  include HandRanks

  def <=>(anOther)
    if rank != anOther.rank   
      return rank <=> anOther.rank
    end

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
      break_pair(anOther)
    when HIGH_CARD
      break_high_card(anOther)
    end
  end
end
