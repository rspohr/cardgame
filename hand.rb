class Hand

  attr_reader :cards
  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def points
    points = @cards.inject(0) { |sum, card| sum + card.check_card_points }
    return validate_presence_of_ace(points)
  end

  def validate_presence_of_ace(points)
    how_many_aces = @cards.select { |x| x.ace? }
    puts "#{@cards}\n"
    puts "#{how_many_aces}"
    while points > 21 && how_many_aces
      how_many_aces.slice!(0)
      points -= 10
    end
    return points
  end
end

