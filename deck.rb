require './card'

class Deck

  attr_reader :cards
  def initialize
    @cards = []
    Card::POSSIBLE_SUITS.each do |suit|
      Card::POSSIBLE_VALUES.each do |card_value|
        @cards << Card.new(card_value, suit)
      end
    end
  end

  def recreate
    @cards = []
    Card::POSSIBLE_SUITS.each do |suit|
      Card::POSSIBLE_VALUES.each do |card_value|
        @cards << Card.new(card_value, suit)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def draw_first_card
    drawn_card = @cards.first
    @cards.delete(drawn_card)
    drawn_card
  end

  def add_card(card)
    @cards << card
  end
end
