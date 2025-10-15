from hand import Hand
from money import Money

class Player:
    def __init__(self):
        self.hand = Hand()
        self.money = Money(0)