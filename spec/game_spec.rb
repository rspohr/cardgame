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

  it "Dealer wins if they have a hidden blackjack and player doesn't" do
    subject.set_up
    card1 = Card.new(:King, :Diamonds)
    card2 = Card.new(:Ace, :Diamonds)
    subject.dealer.cards.clear
    subject.dealer.add_card(card1)
    subject.dealer.add_card(card2)
    expect(subject.first_hand_blackjack(card1, card2)).to eq(true)
    end

  it "Player wins if they have a blackjack and dealer doesn't" do
    subject.set_up
    card1 = Card.new(:King, :Diamonds)
    card2 = Card.new(:Ace, :Diamonds)
    subject.player1.hand.cards.clear
    subject.player1.hand.add_card(card1)
    subject.player1.hand.add_card(card2)
    card3 = Card.new(:King, :Diamonds)
    card4 = Card.new(:Queen, :Diamonds)
    subject.dealer.cards.clear
    subject.dealer.add_card(card3)
    subject.dealer.add_card(card4)
    expect(subject.first_hand_blackjack(subject.player1.hand.cards.first, subject.player1.hand.cards.last)).to eq(true)
  end
end

