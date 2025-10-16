class Money
  
  attr_reader :amount
  def initialize(amount)
    @amount = amount
  end

  def buy_in
    @amount = gets.chomp.to_i
  end

  def lose_money
    @amount = @amount - bet
  end
  
  def lose_money_by_half
    @amount = @amount - bet/2
  end

  def win_money
    @amount = @amount + bet
  end

  def win_blackjack
    @amount = @amount + bet * 3 / 2.0
  end

  def to_s
    "#{@amount}"
  end

  def bet
    5
  end
end
