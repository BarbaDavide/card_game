// lib/domain/models/enemy.dart

// Tipi di nemico
enum EnemyType { normal, elite, boss }

// Intenti nemici (cosa farà nel prossimo turno)
enum EnemyIntent {
  attack,          // Attacco normale
  attackDebuff,    // Attacco + debuff
  debuff,          // Solo debuff
  buff,            // Buff su se stesso
  heal,            // Cura
  special,         // Abilità speciale
  none,            // Nessun intento (inizio turno)
}

// Modello completo del nemico
class Enemy {
  final String id;
  final String name;
  final String description;
  final EnemyType type;
  final EnemyIntent currentIntent;
  final int maxHp;
  final int currentHp;
  final int damage;        // Danno base
  final int intentValue;   // Valore dell'intento (danno, cura, ecc.)
  final int strength;      // Forza (bonus danno)
  final int block;         // Blocco attuale
  final int vulnerability; // Vulnerabilità (danno ricevuto aumentato)
  final int weakness;      // Debolezza (danno inflitto ridotto)
  final int frail;         // Fragilità (blocco ridotto)
  final List<String> powers; // Poteri attivi (es. "Thorns", "Intangible")
  final String imageUrl;   // Chiave per l'asset grafico
  final String theme;      // Tema (per musica/effetti)

  // Costruttore completo
  const Enemy({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.currentIntent,
    required this.maxHp,
    required this.currentHp,
    required this.damage,
    required this.intentValue,
    required this.strength,
    required this.block,
    required this.vulnerability,
    required this.weakness,
    required this.frail,
    required this.powers,
    required this.imageUrl,
    required this.theme,
  });

  // Factory per creare un nemico con HP pieni
  factory Enemy.full({
    required String id,
    required String name,
    required String description,
    required EnemyType type,
    required int maxHp,
    required int damage,
    required String imageUrl,
    EnemyIntent currentIntent = EnemyIntent.none,
    int intentValue = 0,
    int strength = 0,
    int block = 0,
    int vulnerability = 0,
    int weakness = 0,
    int frail = 0,
    List<String> powers = const [],
    String theme = 'normal',
  }) {
    return Enemy(
      id: id,
      name: name,
      description: description,
      type: type,
      currentIntent: currentIntent,
      maxHp: maxHp,
      currentHp: maxHp,
      damage: damage,
      intentValue: intentValue,
      strength: strength,
      block: block,
      vulnerability: vulnerability,
      weakness: weakness,
      frail: frail,
      powers: powers,
      imageUrl: imageUrl,
      theme: theme,
    );
  }

  // Calcola HP percentuale
  double get hpPercent => currentHp / maxHp;

  // Verifica se è morto
  bool get isDead => currentHp <= 0;

  // Verifica se è un boss
  bool get isBoss => type == EnemyType.boss;

  // Verifica se è un elite
  bool get isElite => type == EnemyType.elite;

  // Calcola danno effettivo con forza
  int get effectiveDamage => damage + strength;

  // Calcola danno ricevuto con vulnerabilità/debolezza
  int calculateDamageTaken(int rawDamage) {
    int damage = rawDamage;
    
    // Vulnerabilità aumenta il danno del 50% per stack
    if (vulnerability > 0) {
      damage = (damage * (1 + (vulnerability * 0.5))).toInt();
    }
    
    // Debolezza riduce il danno inflitto (non ricevuto)
    // Frail riduce il blocco
    
    return damage;
  }

  // Calcola blocco effettivo con frail
  int calculateBlock(int rawBlock) {
    int block = rawBlock;
    
    // Frail riduce il blocco del 25% per stack
    if (frail > 0) {
      block = (block * (1 - (frail * 0.25))).toInt();
    }
    
    return block;
  }

  // Crea una copia con HP aggiornati
  Enemy copyWithHp(int newHp) {
    return Enemy(
      id: id,
      name: name,
      description: description,
      type: type,
      currentIntent: currentIntent,
      maxHp: maxHp,
      currentHp: newHp.clamp(0, maxHp),
      damage: damage,
      intentValue: intentValue,
      strength: strength,
      block: block,
      vulnerability: vulnerability,
      weakness: weakness,
      frail: frail,
      powers: powers,
      imageUrl: imageUrl,
      theme: theme,
    );
  }

  // Crea una copia con intento aggiornato
  Enemy copyWithIntent(EnemyIntent newIntent, int newValue) {
    return Enemy(
      id: id,
      name: name,
      description: description,
      type: type,
      currentIntent: newIntent,
      maxHp: maxHp,
      currentHp: currentHp,
      damage: damage,
      intentValue: newValue,
      strength: strength,
      block: block,
      vulnerability: vulnerability,
      weakness: weakness,
      frail: frail,
      powers: powers,
      imageUrl: imageUrl,
      theme: theme,
    );
  }

  // Crea una copia con powers aggiornati
  Enemy copyWithPowers(List<String> newPowers) {
    return Enemy(
      id: id,
      name: name,
      description: description,
      type: type,
      currentIntent: currentIntent,
      maxHp: maxHp,
      currentHp: currentHp,
      damage: damage,
      intentValue: intentValue,
      strength: strength,
      block: block,
      vulnerability: vulnerability,
      weakness: weakness,
      frail: frail,
      powers: newPowers,
      imageUrl: imageUrl,
      theme: theme,
    );
  }

  @override
  String toString() {
    return '$name (HP: $currentHp/$maxHp, Intent: $currentIntent)';
  }
}