// reward.dart

class Reward {
  final String id;
  final String type; // "gold", "card", "relic", "potion", "other"
  final String description;
  final int amount;
  final String? cardId;
  final String? relicId;

  Reward({
    required this.id,
    required this.type,
    required this.description,
    required this.amount,
    this.cardId,
    this.relicId,
  });

  @override
  String toString() => description;
}

class RewardPack {
  final String id;
  final String name;
  final List<Reward> rewards;

  RewardPack({
    required this.id,
    required this.name,
    required this.rewards,
  });

  @override
  String toString() => '$name (${rewards.length} rewards)';
}