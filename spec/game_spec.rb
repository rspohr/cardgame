require 'rspec'
require_relative '../game'

describe Game do
  it 'Player gets 2 cards at setup' do
    subject.set_up
    expect(subject.player1.cards.size).to eq(2)
  end

  it 'Dealer gets 2 cards at setup' do
    subject.set_up
    expect(subject.dealer.cards.size).to eq(2)
  end

  it 'Dealer wins if it has a blackjack' do
    fail
 #   subject.set_up
 #   dealer = Hand.new
 #   dealer.add_card(..)
 #   subject.dealer = dealer

 

#  subject.winner
 
#   subject.winner == "delear"
 
 end


end

