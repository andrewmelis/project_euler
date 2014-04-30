require_relative './game'
require_relative './card'


class Solver
  attr_reader :p1_win_count

  def initialize
    @p1_win_count = 0
    f = File.open("poker.txt")
    f.each_line do |line|
      card_strings = line.split(" ")
      cards = []
      card_strings.each {|c| cards << Card.new(c)}
      game = Game.new(cards)
      game.add_observer(self)
      game.winner?
    end
    
    puts "player1 wins #{@p1_win_count} games"
  end

  def update(number)
    if number == 1
      @p1_win_count += 1
    end
  end
end

Solver.new
