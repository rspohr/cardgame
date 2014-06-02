require './hand'
require './money'

class Player

  attr_reader :hand, :money

  def initialize
    @hand = Hand.new
    @money = Money.new(0)
  end

end
