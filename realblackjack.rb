require './deck'
require './hand'

class RealBlackJack

  def initialize
    @player1 = Hand.new
    @dealer = Hand.new
    @deck = Deck.new
    @deck.shuffle
  end

  def set_up
    puts "\n------------------\nSetting up a new game of Blackjack.\n-----------------"
    @player1.add_card(@deck.draw_first_card)
    @player1.add_card(@deck.draw_first_card)
    @dealer.add_card(@deck.draw_first_card)
    @dealer.add_card(@deck.draw_first_card)
    puts "Player 1's cards:" 
    puts "\n#{@player1.show_cards}"
    puts "Dealer's face-up card: #{@dealer.cards.first}"
  end

  def busted?
    if @player1.points > 21
      puts "\nPlayer busts. Dealer wins."
    else
      turn 
    end 
  end
  
  def choice_yes
      card = @deck.draw_first_card
      @player1.add_card(card)
      puts "\nPlayer 1 draws a card: #{card}"
      puts "Player 1's points: #{@player1.points}."
      @player1.show_cards
      busted?
  end

  def turn
    puts "\nPlayer 1 do you want to draw a card?\n yes / no / score ."
    choice = gets.chomp
    if choice == "yes"
      choice_yes
    elsif choice == "score"
      score
      turn
    else
      dealer_plays
      define_winner
    end
  end

  def dealer_plays
    while @dealer.points < 17
        puts "\nDealer draws a card(#{@dealer.points} points.)"
        @dealer.add_card(@deck.draw_first_card)
    end
  end

  def score
    puts "\nPlayer 1 has #{@player1.points} points."
    puts "Player 1's cards:"
    puts "#{@player1.show_cards}"
    puts "Dealer has #{@dealer.points} points."
    puts "Dealer's cards:" 
    puts "#{@dealer.show_cards}"
  end

  def define_winner
    puts "Player 1's points: #{@player1.points}"
    puts "Dealer's points: #{@dealer.points}"
    if (@player1.points - 21) > 0 && (@dealer.points - 21) <= 0
      puts "Dealer won with #{@dealer.points} points."
    elsif (@player1.points - 21) <= 0 && (@dealer.points - 21) > 0
      puts "Player wins with #{@player1.points} points."
    elsif (@player1.points - 21) <= 0 && (@dealer.points - 21) <= 0
      if @player1.points > @dealer.points
        puts "Player wins with #{@player1.points} points."
      elsif @player1.points < @dealer.points
        puts "Dealer won with #{@dealer.points} points."
      else
        puts "Goddamn it's a draw!"
      end
    else
      puts "Goddamn it's a draw!"
    end
  end

end

realblackjack = RealBlackJack.new
realblackjack.set_up
realblackjack.turn

#create iterative turns for the game
