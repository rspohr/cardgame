require './game'
 
def print_setup_cards(game)
   puts "\n------------------\nSetting up a new game of Blackjack.\n-----------------"
   puts "Player 1's cards:" 
   puts "#{game.player1.hand.show_cards}"
   puts "Player 1 has #{game.player1.money}$"
   puts "Dealer's face-up card: #{game.dealer.cards.first}"
end

def new_game(game) 
  game.set_up
  print_setup_cards(game)
  if game.automatic_defeat
  elsif game.surrender?
  else #while game.player1.money > 0 
    game.turn
  #end
  end
end

game = Game.new
puts "Player 1 how much do you want to buy in for?"
game.player1.money.buy_in
#game.set_up
#new_game(game)
while game.deck.cards.count > 10
  new_game(game)
end
puts "Deck does not have enough cards left to play."

# clear hands
# start new turn
# add/subtract money
