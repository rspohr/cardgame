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
    puts "\nPlayer 1 do you want to draw a card?\n yes / no / score ."
    choice = gets.chomp
    if choice == "yes"
      @player1.add_card(@deck.draw_first_card)
      puts "\nPlayer 1 draws a card."
      puts "Player 1's points: #{@player1.points}."
      table_points_are_less_than_17
      puts "Table's points: #{@table.points}"
      turn
    elsif choice == "score"
      puts "\nPlayer 1 has #{@player1.points} points."
      puts "Player 1's cards:"
      puts "#{@player1.show_cards}"
      puts "Table has #{@table.points} points."
      puts "Table's cards:" 
      puts "#{@table.show_cards}"
      turn
    else
      while @table.points < 17
        table_points_are_less_than_17
      end
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
      puts "\nTable draws a card."
      @table.add_card(@deck.draw_first_card)
    end
  end
end

realblackjack = RealBlackJack.new
realblackjack.turn

#create iterative turns for the game
