// battle_engine.dart

/// Engine di combattimento - solo calcoli puri, nessuna dipendenza da modelli esterni
class BattleEngine {
  /// Calcola il danno effettivo dopo block e modificatori
  static int calculateEffectiveDamage({
    required int baseDamage,
    required int targetBlock,
    bool targetVulnerable = false,
    bool attackerWeak = false,
  }) {
    // Applica Weak prima (-25% danno)
    int damageAfterWeak = attackerWeak 
        ? (baseDamage * 0.75).floor() 
        : baseDamage;
    
    // Applica Vulnerable dopo (+50% danno)
    int damageAfterVulnerable = targetVulnerable 
        ? (damageAfterWeak * 1.5).ceil() 
        : damageAfterWeak;
    
    // Block assorbe il danno
    if (damageAfterVulnerable <= targetBlock) {
      return 0; // Tutto assorbito dal block
    } else {
      return damageAfterVulnerable - targetBlock;
    }
  }

  /// Calcola HP rimanenti dopo danno
  static int calculateRemainingHp({
    required int currentHp,
    required int damageTaken,
  }) {
    final newHp = currentHp - damageTaken;
    return newHp < 0 ? 0 : newHp;
  }

  /// Calcola block rimanente dopo aver assorbito danno
  static int calculateRemainingBlock({
    required int currentBlock,
    required int damageAbsorbed,
  }) {
    final remaining = currentBlock - damageAbsorbed;
    return remaining < 0 ? 0 : remaining;
  }

  /// Determina se un combattente è morto
  static bool isDead({required int currentHp}) {
    return currentHp <= 0;
  }

  /// Calcola mana rimanente dopo aver giocato una carta
  static int calculateRemainingMana({
    required int currentMana,
    required int manaCost,
  }) {
    return currentMana - manaCost;
  }

  /// Verifica se una carta può essere giocata
  static bool canPlayCard({
    required int currentMana,
    required int manaCost,
  }) {
    return currentMana >= manaCost;
  }
}