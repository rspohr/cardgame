class Money

  def initialize(amount)
    @amount = amount
  end

  def buy_in(amount)
    @amount = amount
  end

  def lose_money(amount)
    @amount = @amount - amount
  end

  def win_money(amount)
    @amount = @amount + amount
  end

  def to_s
    "#{@amount}"
  end
end
