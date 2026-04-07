import 'card.dart';

class Deck {
  List<Card> drawPile;
  List<Card> discardPile;
  List<Card> hand;
  List<Card> exhaustPile;

  Deck({
    List<Card> drawPile = const [],
    this.discardPile = const [],
    this.hand = const [],
    this.exhaustPile = const [],
  }) : drawPile = List.from(drawPile);

  // Inizia con mazzo base (10 carte Strike + Defend)
static Deck createStartingDeck() {
  final strike = const Card(
    id: 'strike',
    name: 'Strike',
    description: 'Deal 6 damage.',     // ← AGGIUNGI DESCRIPTION
    manaCost: 1,
    type: CardType.attack,
    rarity: CardRarity.common,
    baseDamage: 6,
  );
  
  final defend = const Card(
    id: 'defend', 
    name: 'Defend',
    description: 'Gain 5 Block.',      // ← AGGIUNGI DESCRIPTION
    manaCost: 1,
    type: CardType.skill,
    rarity: CardRarity.common,
    block: 5,
  );

  final startingCards = List.generate(5, (_) => strike)
    ..addAll(List.generate(5, (_) => defend));
    
  return Deck(drawPile: startingCards)..shuffle();
}

  // Pesca N carte (se mazzo vuoto, reshuffle discard)
  List<Card> draw(int count) {
    final drawn = <Card>[];
    
    while (drawn.length < count && (drawPile.isNotEmpty || discardPile.isNotEmpty)) {
      if (drawPile.isEmpty) {
        _reshuffleDiscard();
      }
      if (drawPile.isNotEmpty) {
        final card = drawPile.removeLast();
        drawn.add(card);
        hand.add(card);
      }
    }
    
    return drawn;
  }

  // Gioca carta (da hand → discard o exhaust)
  void playCard(Card card) {
    hand.remove(card);
    if (card.exhaust) {
      exhaustPile.add(card);
    } else {
      discardPile.add(card);
    }
  }

  // Scarta tutta la mano
  void discardHand() {
    discardPile.addAll(hand);
    hand.clear();
  }

  // Mescola drawPile
  void shuffle() {
    drawPile.shuffle();
  }

  // Reshuffle discard → drawPile
  void _reshuffleDiscard() {
    drawPile.addAll(discardPile);
    discardPile.clear();
    shuffle();
  }

  int get totalCards => drawPile.length + discardPile.length + hand.length + exhaustPile.length;
  int get handSize => hand.length;
  bool get isEmpty => totalCards == 0;

  Deck copy() => Deck(
    drawPile: List.from(drawPile),
    discardPile: List.from(discardPile),
    hand: List.from(hand),
    exhaustPile: List.from(exhaustPile),
  );
}
