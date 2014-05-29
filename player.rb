require './hand'
require './money'

class Player

  attr_reader :hand, :money

  def initialize
    @hand = Hand.new
    @money = 0
  end

  def buy_in
    @money = gets.chomp.to_i
  end

end



