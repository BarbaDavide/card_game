// merchant.dart

class MerchantOffer {
  final String id;
  final String type; // "card", "relic", "remove", "upgrade"
  final String description;
  final int price;
  final String? cardId;
  final String? relicId;

  MerchantOffer({
    required this.id,
    required this.type,
    required this.description,
    required this.price,
    this.cardId,
    this.relicId,
  });

  @override
  String toString() => '$description - $price gold';
}

class Merchant {
  final String id;
  final String name;
  final String greeting;
  final List<MerchantOffer> offers;
  final bool hasBeenVisited;

  Merchant({
    required this.id,
    required this.name,
    required this.greeting,
    required this.offers,
    this.hasBeenVisited = false,
  });

  @override
  String toString() => '$name (${offers.length} offers)';
}