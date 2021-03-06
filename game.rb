require './deck'
require './hand'
require './player'

class Game

  attr_reader :player1, :dealer, :deck

  def initialize
    @player1 = Player.new
    @dealer = Hand.new
    @deck = Deck.new
    @deck.shuffle
  end

  def set_up
    @player1.hand.cards.clear
    @player1.hand.add_card(@deck.draw_first_card)
    @player1.hand.add_card(@deck.draw_first_card)
    @dealer.cards.clear
    @dealer.add_card(@deck.draw_first_card)
    @dealer.add_card(@deck.draw_first_card)
  end

  def busted?
    if @player1.hand.points > 21
      puts "\nPlayer busts. Dealer wins."
      @player1.money.lose_money
    else
      turn 
    end 
  end
  
  def choice_yes
      card = @deck.draw_first_card
      @player1.hand.add_card(card)
      puts "\n-----------------"
      puts "\nPlayer 1 draws a card: #{card}"
      puts "\nPlayer 1's cards: #{@player1.hand.show_cards}"
      puts "\nPlayer 1's points: #{@player1.hand.points}."
      puts "Dealer's face-up card: #{@dealer.cards.first}"
      @player1.hand.show_cards
      busted?
  end

  def automatic_win
      if first_hand_blackjack(@dealer.cards.first,@dealer.cards.last)
        puts "\nDealer has a blackjack. Playes loses."
      @player1.money.lose_money
      return true
    else
      return false
    end
  end  

  def surrender?
    if @dealer.cards.first.value == :Ace
      puts "\nDealer face-up card is an Ace. Player 1 do you want to surrender?"
      choice = gets.chomp
      if choice == "yes"
        puts "Player 1 surrenders."
        @player1.money.lose_money_by_half
        return true
      elsif first_hand_blackjack(@dealer.cards.first, @dealer.cards.last)
        @player1.money.lose_money
        puts "\n Dealer has a blackjack. Dealer wins."
        return true
      else
        return false
      end
    else
    end 
  end

#  def hidden_unmatched_blackjack?(dealer,player1)
#    if dealer.cards.first.check_card_points == 10 && dealer.cards.last.value == :Ace && player1.cards.
#    else 
#    end
#  end

  def first_hand_blackjack(card1,card2)
    if card1.check_card_points == 10 && card2.value == :Ace
      return true
    else
      return false
  end
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
    puts "\n------------------"
    puts "Dealer's cards: #{@dealer.show_cards}"
    while @dealer.points < 17
        @dealer.add_card(@deck.draw_first_card)
        puts "\nDealer draws a card: #{@dealer.cards.last} (#{@dealer.points} points.)"
    end
  end

  def score
    puts "\nPlayer 1 has #{@player1.hand.points} points."
    puts "Player 1's cards:"
    puts "#{@player1.hand.show_cards}"
    puts "Dealer has at least #{@dealer.cards.first.check_card_points} points."
    puts "Dealer's face-up card:" 
    puts "#{@dealer.cards.first}"
  end

  def define_winner
    puts "\n--------------"
    puts "Player 1's points: #{@player1.hand.points}"
    puts "Dealer's points: #{@dealer.points}"
    if (@player1.hand.points - 21) > 0 && (@dealer.points - 21) <= 0
      puts "Dealer wins with #{@dealer.points} points."
      @player1.money.lose_money
    elsif (@player1.hand.points - 21) <= 0 && (@dealer.points - 21) > 0
      puts "Player wins with #{@player1.hand.points} points."
      @player1.money.win_money
    elsif (@player1.hand.points - 21) <= 0 && (@dealer.points - 21) <= 0
      if @player1.hand.points > @dealer.points
        puts "Player wins with #{@player1.hand.points} points."
      @player1.money.win_money
      elsif @player1.hand.points < @dealer.points
        puts "Dealer wins with #{@dealer.points} points."
        @player1.money.lose_money
      else
        puts "Goddamn it's a draw!"
      end
    else
      puts "Goddamn it's a draw!"
    end
  end

end
