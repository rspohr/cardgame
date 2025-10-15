import random
from card import Card

class Deck:
    def __init__(self):
        self.cards = []
        self.recreate()

    def recreate(self):
        self.cards = []
        for suit in Card.POSSIBLE_SUITS:
            for card_value in Card.POSSIBLE_VALUES:
                self.cards.append(Card(card_value, suit))

    def shuffle(self):
        random.shuffle(self.cards)

    def draw_first_card(self):
        if not self.cards:
            return None
        drawn_card = self.cards[0]
        self.cards.remove(drawn_card)
        return drawn_card

    def add_card(self, card):
        self.cards.append(card)