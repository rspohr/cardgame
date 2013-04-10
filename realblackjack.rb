require './deck'
require './hand'

class RealBlackJack

  def initialize
    @player1 = Hand.new
    @dealer = Hand.new
    @deck = Deck.new
    @deck.shuffle
  end

  def turn
    puts "\nPlayer 1 do you want to draw a card?\n yes / no / score ."
    choice = gets.chomp
    if choice == "yes"
      @player1.add_card(@deck.draw_first_card)
      puts "\nPlayer 1 draws a card."
      puts "Player 1's points: #{@player1.points}."
      turn
    elsif choice == "score"
      score
      turn
    else
      dealer_plays
      define_winner
    end
  end

  def dealer_plays
    while @dealer.points < 17 && @player1.points <= 21
        puts "\nDealer draws a card(#{@dealer.points} points.)"
        @dealer.add_card(@deck.draw_first_card)
    end
    while (@player1.points - 21) > (@dealer.points - 21) && @dealer.points < 21 && @player1.points <= 21
      puts "\nDealer takes the risk and draws a card (#{@dealer.points} points.)"
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
realblackjack.turn

#create iterative turns for the game
