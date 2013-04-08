require './deck'
require './hand'

class RealBlackJack

  def initialize
    @player1 = Hand.new
    @table = Hand.new
    @deck = Deck.new
    @deck.shuffle
  end

  def turn
    puts "Player 1 do you want to draw a card? Total of points is: #{@player1.points}."
    choice = gets.chomp
    if choice == "yes"
      @player1.add_card(@deck.draw_first_card)
      table_points_are_less_than_17
      puts "Player 1's points: #{@player1.points}"
      puts "Table's points: #{@table.points}"
      turn
    elsif choice != "yes"
      table_points_are_less_than_17
      puts "Player 1's points: #{@player1.points}"
      puts "Table's points: #{@table.points}"
      define_winner
    end
  end

  def define_winner
    if (@player1.points - 21) > 0 && (@table.points - 21) <= 0
      puts "Table won with #{@table.points} points."
    elsif (@player1.points - 21) <= 0 && (@table.points - 21) > 0
      puts "Player wins with #{@player1.points} points."
    elsif (@player1.points - 21) <= 0 && (@table.points - 21) <= 0
      if @player1.points > @table.points
        puts "Player wins with #{@player1.points} points."
      elsif @player1.points < @table.points
        puts "Table won with #{@table.points} points."
      else
        puts "Goddamn it's a draw!"
      end
    else
      puts "Goddamn it's a draw!"
    end
  end

  def table_points_are_less_than_17
    if @table.points < 17
      @table.add_card(@deck.draw_first_card)
    end
  end
end

realblackjack = RealBlackJack.new
realblackjack.turn

#create iterative turns for the game
