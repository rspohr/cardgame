import unittest
from game import Game
from card import Card

class TestGame(unittest.TestCase):
    def setUp(self):
        self.game = Game()

    def test_player_gets_2_cards_at_setup(self):
        self.game.set_up()
        self.assertEqual(len(self.game.player1.hand.cards), 2)

    def test_dealer_gets_2_cards_at_setup(self):
        self.game.set_up()
        self.assertEqual(len(self.game.dealer.cards), 2)

    def test_dealer_wins_if_they_have_hidden_blackjack_and_player_doesnt(self):
        self.game.set_up()
        card1 = Card('King', 'Diamonds')
        card2 = Card('Ace', 'Diamonds')
        self.game.dealer.cards.clear()
        self.game.dealer.add_card(card1)
        self.game.dealer.add_card(card2)
        self.assertTrue(self.game.first_hand_blackjack(card1, card2))

    def test_player_wins_if_they_have_blackjack_and_dealer_doesnt(self):
        self.game.set_up()
        card1 = Card('King', 'Diamonds')
        card2 = Card('Ace', 'Diamonds')
        self.game.player1.hand.cards.clear()
        self.game.player1.hand.add_card(card1)
        self.game.player1.hand.add_card(card2)
        card3 = Card('King', 'Diamonds')
        card4 = Card('Queen', 'Diamonds')
        self.game.dealer.cards.clear()
        self.game.dealer.add_card(card3)
        self.game.dealer.add_card(card4)
        self.assertTrue(self.game.first_hand_blackjack(self.game.player1.hand.cards[0], self.game.player1.hand.cards[1]))

if __name__ == '__main__':
    unittest.main()


