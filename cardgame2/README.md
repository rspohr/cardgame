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


