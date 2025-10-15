from flask import Flask, jsonify, request, send_from_directory, session
from uuid import uuid4
import os

from game import Game
from card import Card


app = Flask(__name__, static_folder="static", template_folder="templates")
app.secret_key = os.environ.get("BLACKJACK_SECRET", "dev-secret-key")


# Simple in-memory store for sessions
STORE = {}


def _serialize_card(card: Card):
    return {
        "value": card.value,
        "suit": card.suit,
        "label": str(card),
        "points": card.check_card_points(),
    }


def _ensure_session():
    if "sid" not in session:
        session["sid"] = str(uuid4())
    sid = session["sid"]
    if sid not in STORE:
        STORE[sid] = {
            "game": Game(),
            "state": "idle",  # idle | awaiting_surrender | player_turn | round_over
            "message": "",
        }
    return STORE[sid]


def _recreate_deck_if_low(g):
    if len(g.deck.cards) < 10:
        g.deck.recreate()
        g.deck.shuffle()


def _start_round():
    ctx = _ensure_session()
    g: Game = ctx["game"]
    _recreate_deck_if_low(g)
    g.set_up()
    ctx["message"] = ""

    # Dealer hidden blackjack automatic win for dealer
    if g.first_hand_blackjack(g.dealer.cards[0], g.dealer.cards[1]):
        g.player1.money.lose_money()
        ctx["state"] = "round_over"
        ctx["message"] = "Dealer has blackjack. Player loses."
        return ctx

    # Surrender decision if dealer shows Ace
    if g.dealer.cards[0].value == 'Ace':
        ctx["state"] = "awaiting_surrender"
        ctx["message"] = "Dealer shows Ace. Surrender?"
        return ctx

    ctx["state"] = "player_turn"
    return ctx


def _points(hand):
    return hand.points()


def _evaluate_and_settle(g: Game):
    player_points = _points(g.player1.hand)
    dealer_points = _points(g.dealer)
    if player_points > 21 and dealer_points <= 21:
        g.player1.money.lose_money()
        return "Player busts. Dealer wins."
    if player_points <= 21 and dealer_points > 21:
        g.player1.money.win_money()
        return "Dealer busts. Player wins."
    if player_points <= 21 and dealer_points <= 21:
        if player_points > dealer_points:
            g.player1.money.win_money()
            return f"Player wins with {player_points}."
        if player_points < dealer_points:
            g.player1.money.lose_money()
            return f"Dealer wins with {dealer_points}."
        return "It's a draw."
    return "It's a draw."


def _game_view(ctx):
    g: Game = ctx["game"]
    return {
        "state": ctx["state"],
        "message": ctx.get("message", ""),
        "player": {
            "money": g.player1.money.amount,
            "cards": [_serialize_card(c) for c in g.player1.hand.cards],
            "points": _points(g.player1.hand),
        },
        "dealer": {
            "cards": [_serialize_card(c) for c in g.dealer.cards],
            "points": _points(g.dealer),
        },
    }


@app.get("/")
def index():
    return send_from_directory(app.static_folder, "index.html")


@app.post("/api/buy-in")
def buy_in():
    ctx = _ensure_session()
    g: Game = ctx["game"]
    data = request.get_json(silent=True) or {}
    amount = int(data.get("amount", 50))
    g.player1.money.amount = amount
    ctx["state"] = "idle"
    ctx["message"] = "Buy-in set."
    return jsonify(_game_view(ctx))


@app.post("/api/new")
def new_game():
    ctx = _ensure_session()
    ctx = _start_round()
    return jsonify(_game_view(ctx))


@app.post("/api/action")
def action():
    ctx = _ensure_session()
    g: Game = ctx["game"]
    data = request.get_json(silent=True) or {}
    act = data.get("action")

    if ctx["state"] == "awaiting_surrender":
        if act == "surrender_yes":
            g.player1.money.lose_money_by_half()
            ctx["state"] = "round_over"
            ctx["message"] = "Player surrenders. Half bet lost."
        elif act == "surrender_no":
            ctx["state"] = "player_turn"
            ctx["message"] = ""
        return jsonify(_game_view(ctx))

    if ctx["state"] == "player_turn":
        if act == "hit":
            g.player1.hand.add_card(g.deck.draw_first_card())
            if _points(g.player1.hand) > 21:
                g.player1.money.lose_money()
                ctx["state"] = "round_over"
                ctx["message"] = "Player busts. Dealer wins."
        elif act == "stand":
            # Dealer plays
            while _points(g.dealer) < 17:
                g.dealer.add_card(g.deck.draw_first_card())
            ctx["state"] = "round_over"
            ctx["message"] = _evaluate_and_settle(g)
        return jsonify(_game_view(ctx))

    # If round over or idle, ignore invalid actions
    return jsonify(_game_view(ctx))


@app.get("/static/<path:path>")
def static_files(path):
    return send_from_directory(app.static_folder, path)


def create_app():
    return app


if __name__ == "__main__":
    app.run(debug=True)

