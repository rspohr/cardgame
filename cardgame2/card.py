class Card:
    POSSIBLE_SUITS = ['Diamonds', 'Spades', 'Hearts', 'Clubs']
    POSSIBLE_VALUES = ['Ace', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King']

    def __init__(self, value, suit):
        self.value = value
        self.suit = suit

    def __str__(self):
        return f"{self.value} of {self.suit}"

    def is_ace(self):
        return self.value == 'Ace'

    def check_card_points(self):
        if isinstance(self.value, int) and 2 <= self.value <= 10:
            return self.value
        elif self.value == 'Ace':
            return 11
        else:  # Jack, Queen, King
            return 10