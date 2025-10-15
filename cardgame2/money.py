class Money:
    def __init__(self, amount):
        self.amount = amount

    def buy_in(self):
        self.amount = int(input())

    def lose_money(self):
        self.amount = self.amount - self.bet()

    def lose_money_by_half(self):
        self.amount = self.amount - self.bet() // 2

    def win_money(self):
        self.amount = self.amount + self.bet()

    def __str__(self):
        return str(self.amount)

    def bet(self):
        return 5