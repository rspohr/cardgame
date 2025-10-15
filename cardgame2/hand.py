class Hand:
    def __init__(self):
        self.cards = []

    def add_card(self, card):
        self.cards.append(card)

    def points(self):
        points = sum(card.check_card_points() for card in self.cards)
        return self.validate_presence_of_ace(points)

    def validate_presence_of_ace(self, points):
        how_many_aces = sum(1 for card in self.cards if card.is_ace())
        while points > 21:
            if how_many_aces > 0:
                points -= 10
                how_many_aces -= 1
            else:
                break
        return points

    def show_cards(self):
        return ", ".join(str(card) for card in self.cards)