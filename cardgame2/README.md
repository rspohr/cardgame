# Blackjack Game - Python Version

Uma implementação do jogo de Blackjack em Python, baseada na versão Ruby original.

## Estrutura do Projeto

- `card.py` - Classe Card para representar cartas
- `deck.py` - Classe Deck para gerenciar o baralho
- `hand.py` - Classe Hand para gerenciar mãos de cartas
- `money.py` - Classe Money para gerenciar dinheiro/apostas
- `player.py` - Classe Player que combina Hand e Money
- `game.py` - Classe Game com a lógica principal do jogo
- `blackjack.py` - Arquivo principal para executar o jogo
- `test_game.py` - Testes unitários

## Como Executar

### Jogar o jogo:
```bash
python blackjack.py
```

### Executar testes:
```bash
python test_game.py
```

### Interface Web (Flask)

1) Instale dependências (Flask):
```bash
pip install Flask
```

2) Rode o servidor web:
```bash
python -m cardgame2.web.app
```

3) Abra no navegador:
```text
http://127.0.0.1:5000/
```

Controles na Web:
- "Set Buy-in": define a banca inicial (padrão 50)
- "New Round": inicia uma nova rodada (aplica as regras de blackjack, incluindo oferta de rendição quando o dealer mostra Ás)
- "Hit": comprar carta
- "Stand": parar
- "Surrender": se disponível, rende-se e perde metade da aposta

Animações básicas de compra de cartas são aplicadas via CSS.

## Regras do Jogo

- Compra inicial definida pelo usuário
- Aposta fixa de 5 por rodada
- Ás vale 11, rebaixado para 1 conforme necessário
- Dealer compra até ter pelo menos 17 pontos
- Opções do jogador: comprar ("yes"), ver pontuação ("score"), parar ("no")
- Condições especiais: Blackjack inicial e rendição quando dealer mostra Ás

## Funcionalidades

- Sistema de cartas com naipes e valores
- Baralho embaralhado com 52 cartas
- Cálculo automático de pontos com ajuste de Áses
- Sistema de apostas e dinheiro
- Detecção de Blackjack
- Opção de rendição
- Interface de linha de comando interativa


