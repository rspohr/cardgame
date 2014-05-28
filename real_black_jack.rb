require './game'
 
def print_setup_cards(game)
   puts "\n------------------\nSetting up a new game of Blackjack.\n-----------------"
   puts "Player 1's cards:" 
   puts "#{game.player1.show_cards}"
   puts "Dealer's face-up card: #{game.dealer.cards.first}"
end
 
game = Game.new
game.set_up
print_setup_cards(game)
if game.automatic_defeat
elsif game.surrender?
else game.turn
end
