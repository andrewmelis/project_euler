class Card
  include Comparable

  A = 14
  K = 13
  Q = 12
  J = 11
  T = 10

  attr_reader :rank, :suit

  def initialize(card_string)
    @rank = parse_rank(card_string[0].upcase)
    @suit = parse_suit(card_string[1].downcase)
  end

  def parse_rank(rank)
    if rank.to_i >=2 && rank.to_i <=14
      @rank = rank.to_i
    else @rank = Card.const_get(rank)
    end
  end

  def parse_suit(suit)
    if /[cCdDhHsS]/.match(suit) 
      suit
    else raise ArgumentError, "invalid suit parameter"
    end
  end

  def club?
    @suit.eql?("c")
  end

  def diamond?
    @suit.eql?("d")
  end

  def heart?
    @suit.eql?("h")
  end

  def spade?
    @suit.eql?("s")
  end

  def <=>(anOther)
    if anOther.class == Card
      @rank <=> anOther.rank
    elsif anOther.class == Fixnum
      @rank <=> anOther
    else raise RuntimeError, "incompatible comparison"
    end
  end

  def to_s
     "#{@rank}#{@suit}"
  end

  def inspect
    to_s
  end

end
