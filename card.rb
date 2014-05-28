class Card

  attr_reader :value

  POSSIBLE_SUITS = [:Diamonds, :Spades, :Hearts, :Clubs].freeze
  POSSIBLE_VALUES = [:Ace, 2,  3,  4,  5,  6,  7,  8,  9, 10, :Jack, :Queen, :King].freeze

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "#{@value} of #{@suit}"
  end

  def ace?
    @value == :Ace
  end

  def check_card_points
    if @value.to_s.to_i >= 2 && @value.to_s.to_i <= 10
      return @value
    elsif @value == :Ace
      return 11
    else
      return 10
    end
  end
end
