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
    subject.dealer.add_card(card1)
    subject.dealer.add_card(card2)
    expect(subject.dealer_blackjack(card1, card2)).to eq(true)
    end
  end
