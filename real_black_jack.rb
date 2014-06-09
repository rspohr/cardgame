require './game'
 
def print_setup_cards(game)
   puts "\n------------------\nSetting up a new game of Blackjack.\n-----------------"
   puts "Player 1's cards:" 
   puts "#{game.player1.hand.show_cards}"
   puts "Player 1 has #{game.player1.money}$"
   puts "Dealer's face-up card: #{game.dealer.cards.first}"
end

def new_game(game) 
  if game.deck.cards.count < 10
    game.deck.recreate
    game.deck.shuffle
    puts "Deck is running low on cards, re-creating it."
  end
  game.set_up
  print_setup_cards(game)
  if game.automatic_win
  elsif game.surrender?
  else #while game.player1.money > 0 
    game.turn
  #end
  end
end

game = Game.new
puts "Player 1 how much do you want to buy in for?"
game.player1.money.buy_in
while game.player1.money.amount > 0
  new_game(game)
end
puts "Player 1 has run out of money."
# add/subtract money
