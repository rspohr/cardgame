require './hand'
require './deck'

class Game
  def initialize
    @deck = Deck.new
    @player = Hand.new
    @deck.shuffle
  end

  def turn
    card = @deck.draw_first_card
    @player.add_card(card)
    puts "Player's hand: #{@player.cards}."
  end

end

game = Game.new

while true
  puts "Draw a new card?\nt = exits the application"
  draw_card = gets.chomp
  if draw_card == 't'
    break
  end
  game.turn
end
