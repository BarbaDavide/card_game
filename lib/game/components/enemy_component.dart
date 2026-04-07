// lib/services/enemy_ai.dart

import 'dart:math';

/// Sistema AI per nemici satirici-politici (puro Dart, nessuna dipendenza Flutter)
class EnemyAI {
  final Random _random = Random();

  /// Sceglie l'intento successivo basato sul tipo di nemico e stato
  EnemyIntent chooseIntent({
    required String enemyId,
    required int currentHp,
    required int maxHp,
    required bool isFirstTurn,
  }) {
    // Logica satirica specifica per ogni personaggio
    switch (enemyId) {
      case 'donald_trump':
        return _trumpIntent(isFirstTurn);
      case 'vladimir_putin':
        return _putinIntent(currentHp, maxHp);
      case 'elon_musk':
        return _muskIntent();
      case 'bill_gates':
        return _gatesIntent(currentHp, maxHp);
      case 'mark_zuckerberg':
        return _zuckerbergIntent();
      case 'jeff_bezos':
        return _bezosIntent();
      case 'desert_fox':
        return _desertFoxIntent();
      case 'george_soros':
        return _sorosIntent();
      case 'klaus_schwab':
        return _schwabIntent();
      case 'rupert_murdoch':
        return _murdochIntent();
      case 'puppet_master':
        return _puppetMasterIntent(currentHp, maxHp, isFirstTurn);
      default:
        return _defaultIntent();
    }
  }

  // ===== LOGICHE SATIRICHE PER PERSONAGGI =====

  EnemyIntent _trumpIntent(bool isFirstTurn) {
    if (isFirstTurn) {
      return EnemyIntent(
        type: 'special',
        name: 'Twitter Storm',
        description: 'Unleashes chaotic tweets that confuse reality',
        value: _random.nextInt(3) + 1,
        isMultiAttack: true,
      );
    }
    
    final roll = _random.nextInt(10);
    if (roll < 4) {
      return EnemyIntent(
        type: 'attack',
        name: 'Fake News',
        description: 'Deals 12-16 damage with misinformation',
        value: 12 + _random.nextInt(5),
        isMultiAttack: false,
      );
    } else if (roll < 7) {
      return EnemyIntent(
        type: 'special',
        name: 'Reality Distortion',
        description: 'Changes the rules of engagement',
        value: 0,
        isMultiAttack: false,
      );
    } else {
      return EnemyIntent(
        type: 'attack',
        name: 'Campaign Rally',
        description: 'Powerful but slow attack',
        value: 18,
        isMultiAttack: false,
      );
    }
  }

  EnemyIntent _putinIntent(int currentHp, int maxHp) {
    final hpPercent = currentHp / maxHp;
    
    if (hpPercent < 0.4) {
      return EnemyIntent(
        type: 'special',
        name: 'Nuclear Option',
        description: 'Deploys ultimate strategic weapon',
        value: 25,
        isMultiAttack: false,
      );
    }
    
    final roll = _random.nextInt(4);
    if (roll == 0) {
      return EnemyIntent(
        type: 'attack_debuff',
        name: 'Cyber Warfare',
        description: 'Deals 14 damage and applies 1 Weak',
        value: 14,
        isMultiAttack: false,
        attackValue: 14,
        debuffName: 'Weak',
        debuffStacks: 1,
      );
    } else if (roll == 1) {
      return EnemyIntent(
        type: 'debuff',
        name: 'Energy Blackmail',
        description: 'Applies 2 Vulnerable',
        value: 0,
        isMultiAttack: false,
        debuffName: 'Vulnerable',
        debuffStacks: 2,
      );
    } else {
      return EnemyIntent(
        type: 'attack',
        name: 'Bear Hug',
        description: 'Powerful embrace attack',
        value: 16,
        isMultiAttack: false,
      );
    }
  }

  EnemyIntent _muskIntent() {
    final roll = _random.nextInt(5);
    if (roll == 0) {
      return EnemyIntent(
        type: 'special',
        name: 'Rocket Barrage',
        description: 'Launches multiple Starship prototypes',
        value: 20,
        isMultiAttack: true,
      );
    } else if (roll == 1) {
      return EnemyIntent(
        type: 'attack',
        name: 'Meme Attack',
        description: 'Confusing meme assault',
        value: 10,
        isMultiAttack: false,
      );
    } else if (roll == 2) {
      return EnemyIntent(
        type: 'special',
        name: 'Acquire Twitter',
        description: 'Buys the battlefield and manipulates discourse',
        value: 0,
        isMultiAttack: false,
      );
    } else {
      return EnemyIntent(
        type: 'attack',
        name: 'Flamethrower',
        description: 'Direct flame attack',
        value: 14,
        isMultiAttack: false,
      );
    }
  }

  EnemyIntent _gatesIntent(int currentHp, int maxHp) {
    final hpPercent = currentHp / maxHp;
    
    if (hpPercent < 0.5 && _random.nextBool()) {
      return EnemyIntent(
        type: 'special',
        name: 'Vaccine Mandate',
        description: 'Forces compliance while healing',
        value: 8,
        isMultiAttack: false,
        healAmount: 15,
      );
    }
    
    final roll = _random.nextInt(3);
    if (roll == 0) {
      return EnemyIntent(
        type: 'attack_debuff',
        name: 'Mosquito Swarm',
        description: 'Deals 9 damage and applies 1 Weak',
        value: 9,
        isMultiAttack: false,
        attackValue: 9,
        debuffName: 'Weak',
        debuffStacks: 1,
      );
    } else {
      return EnemyIntent(
        type: 'attack',
        name: 'Philanthropic Pressure',
        description: 'Relentless pressure attack',
        value: 11,
        isMultiAttack: false,
      );
    }
  }

  EnemyIntent _zuckerbergIntent() {
    final roll = _random.nextInt(4);
    if (roll == 0) {
      return EnemyIntent(
        type: 'debuff',
        name: 'Algorithm Manipulation',
        description: 'Applies 2 Frail',
        value: 0,
        isMultiAttack: false,
        debuffName: 'Frail',
        debuffStacks: 2,
      );
    } else if (roll == 1) {
      return EnemyIntent(
        type: 'attack',
        name: 'Data Harvesting',
        description: 'Steals personal data for damage',
        value: 13,
        isMultiAttack: false,
      );
    } else {
      return EnemyIntent(
        type: 'special',
        name: 'Metaverse Trap',
        description: 'Traps opponent in virtual reality',
        value: 10,
        isMultiAttack: false,
      );
    }
  }

  EnemyIntent _bezosIntent() {
    final roll = _random.nextInt(3);
    if (roll == 0) {
      return EnemyIntent(
        type: 'attack',
        name: 'Delivery Drones',
        description: 'Swarm attack from multiple drones',
        value: 15,
        isMultiAttack: true,
      );
    } else if (roll == 1) {
      return EnemyIntent(
        type: 'special',
        name: 'Blue Origin Laser',
        description: 'Orbital laser strike',
        value: 22,
        isMultiAttack: false,
      );
    } else {
      return EnemyIntent(
        type: 'attack',
        name: 'Warehouse Strike',
        description: 'Logistics-based attack',
        value: 12,
        isMultiAttack: false,
      );
    }
  }

  EnemyIntent _desertFoxIntent() {
    final roll = _random.nextInt(5);
    if (roll < 2) {
      return EnemyIntent(
        type: 'special',
        name: 'Iron Dome',
        description: 'Deploys missile defense system',
        value: 0,
        isMultiAttack: false,
        blockAmount: 18,
      );
    } else if (roll < 4) {
      return EnemyIntent(
        type: 'attack',
        name: 'Targeted Strike',
        description: 'Precision military strike',
        value: 17,  // CORRETTO: 'value' è il parametro richiesto dal costruttore base
        isMultiAttack: false,
      );
    } else {
      return EnemyIntent(
        type: 'attack_debuff',
        name: 'Preemptive Strike',
        description: 'Strikes first, applies 1 Vulnerable',
        value: 14,
        isMultiAttack: false,
        attackValue: 14,
        debuffName: 'Vulnerable',
        debuffStacks: 1,
      );
    }
  }

  EnemyIntent _sorosIntent() {
    final roll = _random.nextInt(4);
    if (roll == 0) {
      return EnemyIntent(
        type: 'debuff',
        name: 'Currency Manipulation',
        description: 'Applies 2 Weak',
        value: 0,
        isMultiAttack: false,
        debuffName: 'Weak',
        debuffStacks: 2,
      );
    } else if (roll == 1) {
      return EnemyIntent(
        type: 'special',
        name: 'NGO Swarm',
        description: 'Overwhelms with activist groups',
        value: 16,
        isMultiAttack: true,
      );
    } else {
      return EnemyIntent(
        type: 'attack',
        name: 'Color Revolution',
        description: 'Destabilizing attack',
        value: 13,
        isMultiAttack: false,
      );
    }
  }

  EnemyIntent _schwabIntent() {
    final roll = _random.nextInt(3);
    if (roll == 0) {
      return EnemyIntent(
        type: 'debuff',
        name: 'Digital ID',
        description: 'Applies 3 Frail',
        value: 0,
        isMultiAttack: false,
        debuffName: 'Frail',
        debuffStacks: 3,
      );
    } else if (roll == 1) {
      return EnemyIntent(
        type: 'special',
        name: 'Great Reset',
        description: 'Resets battlefield conditions',
        value: 0,
        isMultiAttack: false,
      );
    } else {
      return EnemyIntent(
        type: 'attack',
        name: 'Stakeholder Capitalism',
        description: 'Exploitative economic attack',
        value: 14,
        isMultiAttack: false,
      );
    }
  }

  EnemyIntent _murdochIntent() {
    final roll = _random.nextInt(4);
    if (roll == 0) {
      return EnemyIntent(
        type: 'debuff',
        name: 'Propaganda Wave',
        description: 'Applies 2 Vulnerable',
        value: 0,
        isMultiAttack: false,
        debuffName: 'Vulnerable',
        debuffStacks: 2,
      );
    } else if (roll == 1) {
      return EnemyIntent(
        type: 'attack',
        name: 'News Cycle',
        description: 'Relentless media attack',
        value: 15,
        isMultiAttack: true,
      );
    } else {
      return EnemyIntent(
        type: 'special',
        name: 'Media Empire',
        description: 'Controls narrative to weaken opponent',
        value: 12,
        isMultiAttack: false,
      );
    }
  }

  EnemyIntent _puppetMasterIntent(int currentHp, int maxHp, bool isFirstTurn) {
    if (isFirstTurn) {
      return EnemyIntent(
        type: 'special',
        name: 'String Pulling',
        description: 'Manipulates global events from the shadows',
        value: 0,
        isMultiAttack: false,
      );
    }
    
    final hpPercent = currentHp / maxHp;
    final roll = _random.nextInt(10);
    
    if (hpPercent < 0.3) {
      if (roll < 3) {
        return EnemyIntent(
          type: 'special',
          name: 'Reality Rewrite',
          description: 'Changes fundamental rules of reality',
          value: 30,
          isMultiAttack: false,
        );
      } else if (roll < 6) {
        return EnemyIntent(
          type: 'attack_debuff',
          name: 'Mind Control',
          description: 'Deals 20 damage and applies 2 Weak',
          value: 20,
          isMultiAttack: false,
          attackValue: 20,
          debuffName: 'Weak',
          debuffStacks: 2,
        );
      } else {
        return EnemyIntent(
          type: 'special',
          name: 'Global Conspiracy',
          description: 'Activates sleeper agents worldwide',
          value: 25,
          isMultiAttack: true,
        );
      }
    }
    
    if (roll < 3) {
      return EnemyIntent(
        type: 'attack',
        name: 'Shadow Strike',
        description: 'Covert assassination attempt',
        value: 22,
        isMultiAttack: false,
      );
    } else if (roll < 6) {
      return EnemyIntent(
        type: 'debuff',
        name: 'Perception Manipulation',
        description: 'Applies 2 Vulnerable',
        value: 0,
        isMultiAttack: false,
        debuffName: 'Vulnerable',
        debuffStacks: 2,
      );
    } else {
      return EnemyIntent(
        type: 'special',
        name: 'Economic Collapse',
        description: 'Triggers market crash',
        value: 18,
        isMultiAttack: false,
      );
    }
  }

  EnemyIntent _defaultIntent() {
    return EnemyIntent(
      type: 'attack',
      name: 'Political Attack',
      description: 'Generic political attack',
      value: 8 + _random.nextInt(4),
      isMultiAttack: false,
    );
  }
}

/// Rappresentazione di un intento nemico - LOGICA PURA SENZA DIPENDENZE FLUTTER
class EnemyIntent {
  final String type; // 'attack', 'debuff', 'buff', 'heal', 'special', 'attack_debuff'
  final String name;
  final String description;
  final int value; // Valore generico (danno base o altro)
  final bool isMultiAttack;
  final int? attackValue;    // Danno effettivo per attacchi
  final String? debuffName;  // Nome del debuff applicato
  final int? debuffStacks;   // Numero di stack del debuff
  final int? healAmount;     // Quantità di cura
  final int? blockAmount;    // Quantità di blocco auto-applicato

  const EnemyIntent({
    required this.type,
    required this.name,
    required this.description,
    required this.value,
    required this.isMultiAttack,
    this.attackValue,
    this.debuffName,
    this.debuffStacks,
    this.healAmount,
    this.blockAmount,
  });

  // Helper per logica di gioco
  bool get isAttack => type == 'attack' || type == 'attack_debuff' || (attackValue != null && attackValue! > 0);
  bool get appliesDebuff => debuffName != null && debuffStacks != null && debuffStacks! > 0;
  bool get isHeal => healAmount != null && healAmount! > 0;
  bool get isBlock => blockAmount != null && blockAmount! > 0;
}