const el = (q) => document.querySelector(q);
const dealerCards = el('#dealer-cards');
const playerCards = el('#player-cards');
const dealerPts = el('#dealer-points');
const playerPts = el('#player-points');
const bankroll = el('#bankroll');
const msg = el('#message');

const btnBuyin = el('#btn-buyin');
const btnNew = el('#btn-new');
const btnHit = el('#btn-hit');
const btnStand = el('#btn-stand');
const btnSurrender = el('#btn-surrender');
const buyinAmount = el('#buyin-amount');

function suitSymbol(suit) {
  return {
    Diamonds: '♦',
    Hearts: '♥',
    Spades: '♠',
    Clubs: '♣',
  }[suit] || '?';
}

function renderCard(c) {
  const div = document.createElement('div');
  const red = c.suit === 'Hearts' || c.suit === 'Diamonds';
  div.className = `card${red ? ' red' : ''}`;
  div.innerHTML = `
    <div class="value">${c.value}</div>
    <div class="suit">${suitSymbol(c.suit)}</div>
    <div class="label">${c.suit}</div>
  `;
  return div;
}

function render(state) {
  bankroll.textContent = state.player.money;
  dealerPts.textContent = state.dealer.points;
  playerPts.textContent = state.player.points;
  msg.textContent = state.message || '';

  dealerCards.innerHTML = '';
  state.dealer.cards.forEach((c) => dealerCards.appendChild(renderCard(c)));
  playerCards.innerHTML = '';
  state.player.cards.forEach((c) => playerCards.appendChild(renderCard(c)));

  // Controls state
  btnHit.disabled = !(state.state === 'player_turn');
  btnStand.disabled = !(state.state === 'player_turn');
  btnSurrender.disabled = !(state.state === 'awaiting_surrender');
}

async function api(path, body) {
  const res = await fetch(path, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body || {}),
  });
  return res.json();
}

btnBuyin.addEventListener('click', async () => {
  const amount = parseInt(buyinAmount.value || '50', 10);
  const state = await api('/api/buy-in', { amount });
  render(state);
});

btnNew.addEventListener('click', async () => {
  const state = await api('/api/new');
  render(state);
});

btnHit.addEventListener('click', async () => {
  const state = await api('/api/action', { action: 'hit' });
  render(state);
});

btnStand.addEventListener('click', async () => {
  const state = await api('/api/action', { action: 'stand' });
  render(state);
});

btnSurrender.addEventListener('click', async () => {
  // Toggle surrender yes/no buttons: for simplicity, single click = surrender
  const state = await api('/api/action', { action: 'surrender_yes' });
  render(state);
});

// Initialize with a default buy-in
(async function init() {
  const state = await api('/api/buy-in', { amount: 50 });
  render(state);
})();

