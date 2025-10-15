from deck import Deck
from hand import Hand
from player import Player

class Game:
    def __init__(self):
        self.player1 = Player()
        self.dealer = Hand()
        self.deck = Deck()
        self.deck.shuffle()

    def set_up(self):
        self.player1.hand.cards.clear()
        self.player1.hand.add_card(self.deck.draw_first_card())
        self.player1.hand.add_card(self.deck.draw_first_card())
        self.dealer.cards.clear()
        self.dealer.add_card(self.deck.draw_first_card())
        self.dealer.add_card(self.deck.draw_first_card())

    def busted(self):
        if self.player1.hand.points() > 21:
            print("\nPlayer busts. Dealer wins.")
            self.player1.money.lose_money()
        else:
            self.turn()

    def choice_yes(self):
        card = self.deck.draw_first_card()
        self.player1.hand.add_card(card)
        print("\n-----------------")
        print(f"\nPlayer 1 draws a card: {card}")
        print(f"\nPlayer 1's cards: {self.player1.hand.show_cards()}")
        print(f"\nPlayer 1's points: {self.player1.hand.points()}.")
        print(f"Dealer's face-up card: {self.dealer.cards[0]}")
        self.player1.hand.show_cards()
        self.busted()

    def automatic_win(self):
        if self.first_hand_blackjack(self.dealer.cards[0], self.dealer.cards[1]):
            print("\nDealer has a blackjack. Player loses.")
            self.player1.money.lose_money()
            return True
        else:
            return False

    def surrender(self):
        if self.dealer.cards[0].value == 'Ace':
            print("\nDealer face-up card is an Ace. Player 1 do you want to surrender?")
            choice = input()
            if choice == "yes":
                print("Player 1 surrenders.")
                self.player1.money.lose_money_by_half()
                return True
            elif self.first_hand_blackjack(self.dealer.cards[0], self.dealer.cards[1]):
                self.player1.money.lose_money()
                print("\nDealer has a blackjack. Dealer wins.")
                return True
            else:
                return False
        else:
            return False

    def first_hand_blackjack(self, card1, card2):
        if card1.check_card_points() == 10 and card2.value == 'Ace':
            return True
        else:
            return False

    def turn(self):
        print("\nPlayer 1 do you want to draw a card?\n yes / no / score .")
        choice = input()
        if choice == "yes":
            self.choice_yes()
        elif choice == "score":
            self.score()
            self.turn()
        else:
            self.dealer_plays()
            self.define_winner()

    def dealer_plays(self):
        print("\n------------------")
        print(f"Dealer's cards: {self.dealer.show_cards()}")
        while self.dealer.points() < 17:
            self.dealer.add_card(self.deck.draw_first_card())
            print(f"\nDealer draws a card: {self.dealer.cards[-1]} ({self.dealer.points()} points.)")

    def score(self):
        print(f"\nPlayer 1 has {self.player1.hand.points()} points.")
        print("Player 1's cards:")
        print(f"{self.player1.hand.show_cards()}")
        print(f"Dealer has at least {self.dealer.cards[0].check_card_points()} points.")
        print("Dealer's face-up card:")
        print(f"{self.dealer.cards[0]}")

    def define_winner(self):
        print("\n--------------")
        print(f"Player 1's points: {self.player1.hand.points()}")
        print(f"Dealer's points: {self.dealer.points()}")
        if (self.player1.hand.points() - 21) > 0 and (self.dealer.points() - 21) <= 0:
            print(f"Dealer wins with {self.dealer.points()} points.")
            self.player1.money.lose_money()
        elif (self.player1.hand.points() - 21) <= 0 and (self.dealer.points() - 21) > 0:
            print(f"Player wins with {self.player1.hand.points()} points.")
            self.player1.money.win_money()
        elif (self.player1.hand.points() - 21) <= 0 and (self.dealer.points() - 21) <= 0:
            if self.player1.hand.points() > self.dealer.points():
                print(f"Player wins with {self.player1.hand.points()} points.")
                self.player1.money.win_money()
            elif self.player1.hand.points() < self.dealer.points():
                print(f"Dealer wins with {self.dealer.points()} points.")
                self.player1.money.lose_money()
            else:
                print("Goddamn it's a draw!")
        else:
            print("Goddamn it's a draw!")