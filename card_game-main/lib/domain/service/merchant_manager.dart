// merchant_manager.dart

/// Gestore del mercante - opera su ID semplici (stringhe) per evitare dipendenze
class MerchantManager {
  /// Acquista una carta: aggiunge la carta al mazzo e rimuove l'oro
  static List<dynamic> purchaseCard({
    required int currentGold,
    required List<String> deck,
    required String cardId,
    required int price,
  }) {
    if (currentGold < price) {
      return [currentGold, deck, false]; // [gold, deck, success]
    }
    
    final newGold = currentGold - price;
    final newDeck = List<String>.from(deck)..add(cardId);
    
    return [newGold, newDeck, true];
  }

  /// Rimuovi una carta dal mazzo (servizio del mercante)
  static List<dynamic> removeCard({
    required int currentGold,
    required List<String> deck,
    required String cardIdToRemove,
    required int price,
  }) {
    if (currentGold < price) {
      return [currentGold, deck, false];
    }
    
    final newGold = currentGold - price;
    final newDeck = List<String>.from(deck)..remove(cardIdToRemove);
    
    return [newGold, newDeck, true];
  }

  /// Acquista una reliquia
  static List<dynamic> purchaseRelic({
    required int currentGold,
    required List<String> relics,
    required String relicId,
    required int price,
  }) {
    if (currentGold < price) {
      return [currentGold, relics, false];
    }
    
    final newGold = currentGold - price;
    final newRelics = List<String>.from(relics)..add(relicId);
    
    return [newGold, newRelics, true];
  }

  /// Verifica se un'offerta è acquistabile
  static bool canAfford({
    required int currentGold,
    required int price,
  }) {
    return currentGold >= price;
  }

  /// Calcola il costo scontato (es. per eventi speciali)
  static int calculateDiscountedPrice({
    required int originalPrice,
    required double discountPercent, // 0.0 a 1.0 (es. 0.25 = 25% sconto)
  }) {
    final discount = (originalPrice * discountPercent).floor();
    return originalPrice - discount;
  }

  /// Applica sconto speciale "buy one get one half price" per carte
  static int calculateBoGoPrice({
    required int firstCardPrice,
    required int secondCardPrice,
  }) {
    final halfPrice = (secondCardPrice * 0.5).ceil();
    return firstCardPrice + halfPrice;
  }
}