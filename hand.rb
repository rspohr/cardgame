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
    how_many_aces = @cards.select { |x| x.ace? }.count
    while points > 21
      if how_many_aces > 0
        points -= 10
        how_many_aces -= 1
      else
        break
      end
    end
    return points
  end

  def show_cards
    "#{@cards.join(", ")}"
  end
end


