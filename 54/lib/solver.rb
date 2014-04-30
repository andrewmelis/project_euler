require_relative './game'
require_relative './card'

class Solver
  attr_reader :p1_win_count

  def initialize(filename)
    @p1_win_count = 0
    f = File.open(filename)
    solve_file(f)
  end

  def solve_file(f)
    f.each_line do |line|
      cards = make_cards_from_line(line)
      game = Game.new(cards)
      game.add_observer(self)
      game.winner?
    end
  end

  def make_cards_from_line(line)
    card_strings = line.split(" ")
    cards = []
    card_strings.each {|c| cards << Card.new(c)}
    cards
  end

  def update(number)
    if number == 1
      @p1_win_count += 1
    end
  end
end
