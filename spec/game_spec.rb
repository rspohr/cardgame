require 'rspec'
require_relative '../game'

describe Game do
  it 'Player gets 2 cards at setup' do
    subject.set_up
    expect(subject.player1.hand.cards.size).to eq(2)
  end

  it 'Dealer gets 2 cards at setup' do
    subject.set_up
    expect(subject.dealer.cards.size).to eq(2)
  end

  describe '#automatic_win' do
    before do
      subject.player1.money.instance_variable_set(:@amount, 10)
    end

    it "resolves to a push when both player and dealer have blackjack" do
      subject.player1.hand.cards.clear
      subject.player1.hand.add_card(Card.new(:Ace, :Spades))
      subject.player1.hand.add_card(Card.new(:King, :Hearts))

      subject.dealer.cards.clear
      subject.dealer.add_card(Card.new(:Ace, :Clubs))
      subject.dealer.add_card(Card.new(:Queen, :Diamonds))

      expect(subject.automatic_win).to eq(true)
      expect(subject.player1.money.amount).to eq(10)
    end

    it "pays 3:2 when only the player has blackjack" do
      subject.player1.hand.cards.clear
      subject.player1.hand.add_card(Card.new(:Ace, :Spades))
      subject.player1.hand.add_card(Card.new(:King, :Hearts))

      subject.dealer.cards.clear
      subject.dealer.add_card(Card.new(:Nine, :Clubs))
      subject.dealer.add_card(Card.new(:Seven, :Diamonds))

      expect(subject.automatic_win).to eq(true)
      expect(subject.player1.money.amount).to eq(17.5)
    end

    it "causes an immediate loss when only the dealer has blackjack" do
      subject.player1.hand.cards.clear
      subject.player1.hand.add_card(Card.new(:Nine, :Clubs))
      subject.player1.hand.add_card(Card.new(:Seven, :Diamonds))

      subject.dealer.cards.clear
      subject.dealer.add_card(Card.new(:Ace, :Spades))
      subject.dealer.add_card(Card.new(:King, :Hearts))

      expect(subject.automatic_win).to eq(true)
      expect(subject.player1.money.amount).to eq(5)
    end
  end
end

