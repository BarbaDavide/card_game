// deck_manager.dart

/// Gestore del mazzo - opera su ID carte (stringhe) per evitare dipendenze
class DeckManager {
  /// Pesca N carte dal draw pile
  /// Restituisce: [drawnCards, newDrawPile, newDiscardPile]
  static List<List<String>> drawCards({
    required List<String> drawPile,
    required List<String> discardPile,
    required int count,
  }) {
    final drawn = <String>[];
    var newDrawPile = List<String>.from(drawPile);
    var newDiscardPile = List<String>.from(discardPile);

    for (var i = 0; i < count && (newDrawPile.isNotEmpty || newDiscardPile.isNotEmpty); i++) {
      // Reshuffle se draw pile vuota
      if (newDrawPile.isEmpty) {
        newDrawPile = List<String>.from(newDiscardPile);
        newDiscardPile.clear();
        // Mescola (semplice shuffle casuale)
        newDrawPile = _shuffleList(newDrawPile);
      }

      // Pesca la carta in cima
      if (newDrawPile.isNotEmpty) {
        final card = newDrawPile.removeLast();
        drawn.add(card);
      }
    }

    return [drawn, newDrawPile, newDiscardPile];
  }

  /// Gioca una carta: sposta da hand a discard pile
  static List<String> playCard({
    required List<String> hand,
    required List<String> discardPile,
    required String cardId,
  }) {
    final newHand = List<String>.from(hand);
    final newDiscardPile = List<String>.from(discardPile);

    // Rimuovi la carta dalla mano
    newHand.remove(cardId);
    // Aggiungi alla discard pile
    newDiscardPile.add(cardId);

    return newDiscardPile;
  }

  /// Scarta tutta la mano
  static List<String> discardHand({
    required List<String> hand,
    required List<String> discardPile,
  }) {
    final newDiscardPile = List<String>.from(discardPile);
    newDiscardPile.addAll(hand);
    return newDiscardPile;
  }

  /// Reshuffle: sposta tutte le carte dalla discard pile alla draw pile e mescola
  static List<String> reshuffle({
    required List<String> drawPile,
    required List<String> discardPile,
  }) {
    final newDrawPile = List<String>.from(drawPile);
    final newDiscardPile = List<String>.from(discardPile);

    // Aggiungi tutte le carte dalla discard alla draw
    newDrawPile.addAll(newDiscardPile);
    newDiscardPile.clear();

    // Mescola
    return _shuffleList(newDrawPile);
  }

  /// Conta le carte totali nel mazzo
  static int countTotalCards({
    required List<String> drawPile,
    required List<String> discardPile,
    required List<String> hand,
    required List<String> exhaustPile,
  }) {
    return drawPile.length + discardPile.length + hand.length + exhaustPile.length;
  }

  /// Helper privato: shuffle semplice (Fisher-Yates)
  static List<String> _shuffleList(List<String> list) {
    final shuffled = List<String>.from(list);
    for (var i = shuffled.length - 1; i > 0; i--) {
      final j = _randomInt(i + 1);
      final temp = shuffled[i];
      shuffled[i] = shuffled[j];
      shuffled[j] = temp;
    }
    return shuffled;
  }

  /// Helper privato: generatore casuale semplice (senza dart:math)
  static int _randomInt(int max) {
    // Usa timestamp per casualità semplice (non crittografica)
    return (DateTime.now().millisecondsSinceEpoch % max);
  }
}