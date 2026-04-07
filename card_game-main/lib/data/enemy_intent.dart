// lib/data/enemy_intent.dart

/// Definizioni delle azioni/intenti dei nemici
class EnemyIntentDefinition {
  final String name;
  final String description;
  final String icon; // Emoji o codice icona
  final bool isAttack;
  final bool appliesDebuff;
  final bool isBuff;

  const EnemyIntentDefinition({
    required this.name,
    required this.description,
    required this.icon,
    required this.isAttack,
    required this.appliesDebuff,
    required this.isBuff,
  });

  factory EnemyIntentDefinition.attack({int damage = 0}) {
    return EnemyIntentDefinition(
      name: 'Attack',
      description: 'Deals $damage damage',
      icon: '⚔️',
      isAttack: true,
      appliesDebuff: false,
      isBuff: false,
    );
  }

  factory EnemyIntentDefinition.attackDebuff({int damage = 0, String debuff = ''}) {
    return EnemyIntentDefinition(
      name: 'Attack + $debuff',
      description: 'Deals $damage damage and applies $debuff',
      icon: '💀',
      isAttack: true,
      appliesDebuff: true,
      isBuff: false,
    );
  }

  factory EnemyIntentDefinition.debuff({String debuff = '', int stacks = 1}) {
    return EnemyIntentDefinition(
      name: debuff,
      description: 'Applies $stacks stack(s) of $debuff',
      icon: '⚠️',
      isAttack: false,
      appliesDebuff: true,
      isBuff: false,
    );
  }

  factory EnemyIntentDefinition.buff({String buff = '', int stacks = 1}) {
    return EnemyIntentDefinition(
      name: buff,
      description: 'Gains $stacks stack(s) of $buff',
      icon: '🛡️',
      isAttack: false,
      appliesDebuff: false,
      isBuff: true,
    );
  }

  factory EnemyIntentDefinition.heal({int amount = 0}) {
    return EnemyIntentDefinition(
      name: 'Heal',
      description: 'Heals for $amount HP',
      icon: '❤️',
      isAttack: false,
      appliesDebuff: false,
      isBuff: false,
    );
  }

  factory EnemyIntentDefinition.special({String name = '', String description = ''}) {
    return EnemyIntentDefinition(
      name: name,
      description: description,
      icon: '✨',
      isAttack: false,
      appliesDebuff: false,
      isBuff: false,
    );
  }
}

/// Helper per ottenere intenti predefiniti
class EnemyIntents {
  static final Map<String, EnemyIntentDefinition> definitions = {
    // Attacchi normali
    'attack6': EnemyIntentDefinition.attack(damage: 6),
    'attack8': EnemyIntentDefinition.attack(damage: 8),
    'attack10': EnemyIntentDefinition.attack(damage: 10),
    'attack12': EnemyIntentDefinition.attack(damage: 12),
    'attack15': EnemyIntentDefinition.attack(damage: 15),
    'attack20': EnemyIntentDefinition.attack(damage: 20),
    'attack25': EnemyIntentDefinition.attack(damage: 25),
    'attack30': EnemyIntentDefinition.attack(damage: 30),
    
    // Attacchi + debuff
    'attackVulnerable': EnemyIntentDefinition.attackDebuff(damage: 8, debuff: 'Vulnerable'),
    'attackWeak': EnemyIntentDefinition.attackDebuff(damage: 10, debuff: 'Weak'),
    'attackFrail': EnemyIntentDefinition.attackDebuff(damage: 7, debuff: 'Frail'),
    
    // Debuff soli
    'vulnerable': EnemyIntentDefinition.debuff(debuff: 'Vulnerable', stacks: 2),
    'weak': EnemyIntentDefinition.debuff(debuff: 'Weak', stacks: 1),
    'frail': EnemyIntentDefinition.debuff(debuff: 'Frail', stacks: 1),
    'strengthDown': EnemyIntentDefinition.debuff(debuff: 'Strength Down', stacks: 1),
    
    // Buff
    'strengthUp': EnemyIntentDefinition.buff(buff: 'Strength', stacks: 2),
    'block': EnemyIntentDefinition.buff(buff: 'Block', stacks: 10),
    'thorns': EnemyIntentDefinition.buff(buff: 'Thorns', stacks: 3),
    'intangible': EnemyIntentDefinition.buff(buff: 'Intangible', stacks: 1),
    
    // Cura
    'heal5': EnemyIntentDefinition.heal(amount: 5),
    'heal10': EnemyIntentDefinition.heal(amount: 10),
    'heal15': EnemyIntentDefinition.heal(amount: 15),
    
    // Speciali satirici
    'fakeNews': EnemyIntentDefinition.special(
      name: 'Fake News',
      description: 'Confuses the player and deals unpredictable damage',
    ),
    'twitterStorm': EnemyIntentDefinition.special(
      name: 'Twitter Storm',
      description: 'Overwhelms with rapid-fire attacks',
    ),
    'cyberAttack': EnemyIntentDefinition.special(
      name: 'Cyber Attack',
      description: 'Hacks your systems and applies multiple debuffs',
    ),
    'darkMoney': EnemyIntentDefinition.special(
      name: 'Dark Money',
      description: 'Corrupts the battlefield and heals',
    ),
    'propaganda': EnemyIntentDefinition.special(
      name: 'Propaganda',
      description: 'Manipulates perception and buffs self',
    ),
  };

  static EnemyIntentDefinition get(String key) {
    return definitions[key] ?? EnemyIntentDefinition.attack(damage: 6);
  }
}