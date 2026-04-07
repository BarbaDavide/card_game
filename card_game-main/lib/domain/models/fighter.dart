enum StatusEffect { strength, dexterity, poison, vulnerable, weak }

class Fighter {
  final String name;
  final int maxHp;
  int currentHp;
  int currentBlock;
  final int maxMana;
  int currentMana;
  List<StatusEffect> statusEffects;
  Map<StatusEffect, int> statusValues;

  Fighter({
    required this.name,
    required this.maxHp,
    int manaMax = 4,
    int hpCurrent = 50,
    int blockCurrent = 0,
    int manaCurrent = 4,
    List<StatusEffect> effects = const [],
    Map<StatusEffect, int> values = const {},
  }) : maxMana = manaMax.clamp(1, 10),
       currentHp = hpCurrent.clamp(1, maxHp),
       currentBlock = blockCurrent.clamp(0, 100),
       currentMana = manaCurrent.clamp(0, manaMax.clamp(1, 10)),
       statusEffects = List.from(effects),
       statusValues = Map.from(values);

  void startTurn() {
    currentBlock = 0;
    currentMana = maxMana;
  }

  bool spendMana(int cost) {
    if (currentMana >= cost) {
      currentMana -= cost;
      return true;
    }
    return false;
  }

  void gainMana(int amount) {
    currentMana = (currentMana + amount).clamp(0, maxMana);
  }

  void takeDamage(int damage) {
    final remaining = (damage - currentBlock).clamp(0, damage);
    currentBlock = 0;
    currentHp -= remaining;
    currentHp = currentHp.clamp(0, maxHp);
  }

  void gainBlock(int amount) {
    currentBlock += amount;
  }

  void applyStatus(StatusEffect effect, int stacks) {
    statusValues[effect] = (statusValues[effect] ?? 0) + stacks;
  }

  bool get isDead => currentHp <= 0;

  @override
  String toString() => '$name (HP:${currentHp}/${maxHp} M:${currentMana}/${maxMana})';
}