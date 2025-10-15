from game import Game
import argparse
import builtins

# Global auto-play state (used only when --auto is enabled)
AUTO_STATE = None


def print_setup_cards(game):
    print("\n------------------\nSetting up a new game of Blackjack.\n-----------------")
    print("Player 1's cards:")
    print(f"{game.player1.hand.show_cards()}")
    print(f"Player 1 has {game.player1.money}$")
    print(f"Dealer's face-up card: {game.dealer.cards[0]}")


def new_game(game):
    if len(game.deck.cards) < 10:
        game.deck.recreate()
        game.deck.shuffle()
        print("Deck is running low on cards, re-creating it.")
    game.set_up()
    # Mark the start of a new round for auto mode decisions
    if isinstance(AUTO_STATE, dict):
        AUTO_STATE["round_first_decision"] = True
        AUTO_STATE["rounds_played"] = AUTO_STATE.get("rounds_played", 0) + 1
    print_setup_cards(game)
    if game.automatic_win():
        pass
    elif game.surrender():
        pass
    else:
        game.turn()


def _install_auto_input(game, buy_in, hit_until, surrender_when_ace):
    """Replace builtins.input to drive the game automatically.

    Strategy:
    - First input is the buy-in amount.
    - If dealer shows an Ace and this is the first decision of the round,
      answer with surrender choice based on flag.
    - During player's turn: hit while player's points < hit_until, else stand.
    """
    state = {
        "first_call": True,
    }

    original_input = builtins.input

    def auto_input(_prompt: str = "") -> str:
        # First input call is the buy-in
        if state["first_call"]:
            state["first_call"] = False
            return str(buy_in)

        # If we're at the start of a round and dealer shows an Ace, decide surrender
        if isinstance(AUTO_STATE, dict) and AUTO_STATE.get("round_first_decision"):
            AUTO_STATE["round_first_decision"] = False
            try:
                if len(game.dealer.cards) >= 1 and game.dealer.cards[0].value == 'Ace':
                    return "yes" if surrender_when_ace else "no"
            except Exception:
                # Fall back to normal decision flow if anything is off
                pass

        # Otherwise, make a hit/stand decision based on player's points
        try:
            pts = game.player1.hand.points()
            return "yes" if pts < hit_until else "no"
        except Exception:
            # Safe fallback
            return "no"

    builtins.input = auto_input
    return original_input


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Blackjack game")
    parser.add_argument("--auto", action="store_true", help="Run in non-interactive auto mode")
    parser.add_argument("--buy-in", type=int, default=50, help="Initial buy-in amount for auto mode")
    parser.add_argument(
        "--hit-until", type=int, default=17, help="Auto mode: hit while points are below this threshold"
    )
    parser.add_argument(
        "--surrender-when-ace",
        action="store_true",
        help="Auto mode: surrender when dealer's face-up card is an Ace",
    )
    parser.add_argument(
        "--max-rounds",
        type=int,
        default=0,
        help="Auto mode: limit number of rounds (0 = unlimited until bankroll is 0)",
    )
    args = parser.parse_args()

    game = Game()

    if args.auto:
        # Initialize auto state and install auto input handler
        AUTO_STATE = {"round_first_decision": False, "rounds_played": 0}
        original_input = _install_auto_input(
            game,
            buy_in=args.buy_in,
            hit_until=args.hit_until,
            surrender_when_ace=args.surrender_when_ace,
        )
    else:
        original_input = None

    try:
        print("Player 1 how much do you want to buy in for?")
        game.player1.money.buy_in()
        rounds_played = 0
        while game.player1.money.amount > 0:
            new_game(game)
            rounds_played += 1
            if args.auto and args.max_rounds and rounds_played >= args.max_rounds:
                break
        print("Player 1 has run out of money." if game.player1.money.amount <= 0 else "Game over.")
    finally:
        # Restore original input when leaving auto mode
        if original_input is not None:
            builtins.input = original_input


