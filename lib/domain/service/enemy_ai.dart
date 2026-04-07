// lib/services/enemy_ai.dart

import 'dart:math';

// NON importare Flutter qui - la logica AI deve essere indipendente dall'UI
// Tutti i riferimenti a Colors/Icons sono stati rimossi dalla classe EnemyIntent

/// Sistema AI per nemici satirici-politici
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
      // Primo turno: annuncio caotico
      return EnemyIntent.special(
        name: 'Twitter Storm',
        description: 'Unleashes chaotic tweets that confuse reality',
        value: _random.nextInt(3) + 1, // 1-3 attacchi casuali
        isMultiAttack: true,
      );
    }
    
    // Turni successivi: imprevedibile
    final roll = _random.nextInt(10);
    if (roll < 4) {
      return EnemyIntent.attack(
        name: 'Fake News',
        value: 12 + _random.nextInt(5), // 12-16 danno
      );
    } else if (roll < 7) {
      return EnemyIntent.special(
        name: 'Reality Distortion',
        description: 'Changes the rules of engagement',
        value: 0,
      );
    } else {
      return EnemyIntent.attack(
        name: 'Campaign Rally',
        value: 18, // Attacco potente ma lento
      );
    }
  }

  EnemyIntent _putinIntent(int currentHp, int maxHp) {
    final hpPercent = currentHp / maxHp;
    
    // Quando è ferito, diventa più pericoloso (strategia del cornered animal)
    if (hpPercent < 0.4) {
      return EnemyIntent.special(
        name: 'Nuclear Option',
        description: 'Deploys ultimate strategic weapon',
        value: 25,
      );
    }
    
    // Strategia calcolata: alterna attacchi e debuff
    final roll = _random.nextInt(4);
    if (roll == 0) {
      return EnemyIntent.attackDebuff(
        name: 'Cyber Warfare',
        attackValue: 14,
        debuffName: 'Weak',
        debuffStacks: 1,
      );
    } else if (roll == 1) {
      return EnemyIntent.debuff(
        name: 'Energy Blackmail',
        debuffName: 'Vulnerable',
        debuffStacks: 2,
      );
    } else {
      return EnemyIntent.attack(
        name: 'Bear Hug',
        value: 16,
      );
    }
  }

  EnemyIntent _muskIntent() {
    final roll = _random.nextInt(5);
    if (roll == 0) {
      return EnemyIntent.special(
        name: 'Rocket Barrage',
        description: 'Launches multiple Starship prototypes',
        value: 20,
        isMultiAttack: true,
      );
    } else if (roll == 1) {
      return EnemyIntent.attack(
        name: 'Meme Attack',
        value: 10,
      );
    } else if (roll == 2) {
      return EnemyIntent.special(
        name: 'Acquire Twitter',
        description: 'Buys the battlefield and manipulates discourse',
        value: 0,
      );
    } else {
      return EnemyIntent.attack(
        name: 'Flamethrower',
        value: 14,
      );
    }
  }

  EnemyIntent _gatesIntent(int currentHp, int maxHp) {
    final hpPercent = currentHp / maxHp;
    
    // Quando sotto il 50% HP, attiva "philanthropy" (cura + attacco)
    if (hpPercent < 0.5 && _random.nextBool()) {
      return EnemyIntent.special(
        name: 'Vaccine Mandate',
        description: 'Forces compliance while healing',
        value: 8, // danno
        healAmount: 15,
      );
    }
    
    final roll = _random.nextInt(3);
    if (roll == 0) {
      return EnemyIntent.attackDebuff(
        name: 'Mosquito Swarm',
        attackValue: 9,
        debuffName: 'Weak',
        debuffStacks: 1,
      );
    } else {
      return EnemyIntent.attack(
        name: 'Philanthropic Pressure',
        value: 11,
      );
    }
  }

  EnemyIntent _zuckerbergIntent() {
    final roll = _random.nextInt(4);
    if (roll == 0) {
      return EnemyIntent.debuff(
        name: 'Algorithm Manipulation',
        debuffName: 'Frail',
        debuffStacks: 2,
      );
    } else if (roll == 1) {
      return EnemyIntent.attack(
        name: 'Data Harvesting',
        value: 13,
      );
    } else {
      return EnemyIntent.special(
        name: 'Metaverse Trap',
        description: 'Traps opponent in virtual reality',
        value: 10,
      );
    }
  }

  EnemyIntent _bezosIntent() {
    final roll = _random.nextInt(3);
    if (roll == 0) {
      return EnemyIntent.attack(
        name: 'Delivery Drones',
        value: 15,
        isMultiAttack: true,
      );
    } else if (roll == 1) {
      return EnemyIntent.special(
        name: 'Blue Origin Laser',
        description: 'Orbital laser strike',
        value: 22,
      );
    } else {
      return EnemyIntent.attack(
        name: 'Warehouse Strike',
        value: 12,
      );
    }
  }

  EnemyIntent _desertFoxIntent() {
    // Strategia militare: difesa prima, poi attacco potente
    final roll = _random.nextInt(5);
    if (roll < 2) {
      return EnemyIntent.special(
        name: 'Iron Dome',
        description: 'Deploys missile defense system',
        blockAmount: 18,
      );
    } else if (roll < 4) {
      return EnemyIntent.attack(
        name: 'Targeted Strike',
        value: 17,
      );
    } else {
      return EnemyIntent.attackDebuff(
        name: 'Preemptive Strike',
        attackValue: 14,
        debuffName: 'Vulnerable',
        debuffStacks: 1,
      );
    }
  }

  EnemyIntent _sorosIntent() {
    final roll = _random.nextInt(4);
    if (roll == 0) {
      return EnemyIntent.debuff(
        name: 'Currency Manipulation',
        debuffName: 'Weak',
        debuffStacks: 2,
      );
    } else if (roll == 1) {
      return EnemyIntent.special(
        name: 'NGO Swarm',
        description: 'Overwhelms with activist groups',
        value: 16,
        isMultiAttack: true,
      );
    } else {
      return EnemyIntent.attack(
        name: 'Color Revolution',
        value: 13,
      );
    }
  }

  EnemyIntent _schwabIntent() {
    final roll = _random.nextInt(3);
    if (roll == 0) {
      return EnemyIntent.debuff(
        name: 'Digital ID',
        debuffName: 'Frail',
        debuffStacks: 3,
      );
    } else if (roll == 1) {
      return EnemyIntent.special(
        name: 'Great Reset',
        description: 'Resets battlefield conditions',
        value: 0,
      );
    } else {
      return EnemyIntent.attack(
        name: 'Stakeholder Capitalism',
        value: 14,
      );
    }
  }

  EnemyIntent _murdochIntent() {
    final roll = _random.nextInt(4);
    if (roll == 0) {
      return EnemyIntent.debuff(
        name: 'Propaganda Wave',
        debuffName: 'Vulnerable',
        debuffStacks: 2,
      );
    } else if (roll == 1) {
      return EnemyIntent.attack(
        name: 'News Cycle',
        value: 15,
        isMultiAttack: true,
      );
    } else {
      return EnemyIntent.special(
        name: 'Media Empire',
        description: 'Controls narrative to weaken opponent',
        value: 12,
      );
    }
  }

  EnemyIntent _puppetMasterIntent(int currentHp, int maxHp, bool isFirstTurn) {
    if (isFirstTurn) {
      return EnemyIntent.special(
        name: 'String Pulling',
        description: 'Manipulates global events from the shadows',
        value: 0,
      );
    }
    
    final hpPercent = currentHp / maxHp;
    final roll = _random.nextInt(10);
    
    // Boss finale: diventa più pericoloso quando ferito
    if (hpPercent < 0.3) {
      if (roll < 3) {
        return EnemyIntent.special(
          name: 'Reality Rewrite',
          description: 'Changes fundamental rules of reality',
          value: 30,
        );
      } else if (roll < 6) {
        return EnemyIntent.attackDebuff(
          name: 'Mind Control',
          attackValue: 20,
          debuffName: 'Weak',
          debuffStacks: 2,
        );
      } else {
        return EnemyIntent.special(
          name: 'Global Conspiracy',
          description: 'Activates sleeper agents worldwide',
          value: 25,
          isMultiAttack: true,
        );
      }
    }
    
    // Fase normale
    if (roll < 3) {
      return EnemyIntent.attack(
        name: 'Shadow Strike',
        value: 22,
      );
    } else if (roll < 6) {
      return EnemyIntent.debuff(
        name: 'Perception Manipulation',
        debuffName: 'Vulnerable',
        debuffStacks: 2,
      );
    } else {
      return EnemyIntent.special(
        name: 'Economic Collapse',
        description: 'Triggers market crash',
        value: 18,
      );
    }
  }

  EnemyIntent _defaultIntent() {
    return EnemyIntent.attack(
      name: 'Political Attack',
      value: 8 + _random.nextInt(4),
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

  // Costruttori convenienti
  EnemyIntent.attack({
    required String name,
    required int value,
    String description = '',
    bool isMultiAttack = false,
  }) : this(
          type: 'attack',
          name: name,
          description: description.isNotEmpty
              ? description
              : 'Deals $value damage',
          value: value,
          isMultiAttack: isMultiAttack,
          attackValue: value,
          debuffName: null,
          debuffStacks: null,
          healAmount: null,
          blockAmount: null,
        );

  EnemyIntent.debuff({
    required String name,
    required String debuffName,
    required int debuffStacks,
    String description = '',
  }) : this(
          type: 'debuff',
          name: name,
          description: description.isNotEmpty
              ? description
              : 'Applies $debuffStacks stack(s) of $debuffName',
          value: 0,
          isMultiAttack: false,
          attackValue: null,
          debuffName: debuffName,
          debuffStacks: debuffStacks,
          healAmount: null,
          blockAmount: null,
        );

  EnemyIntent.attackDebuff({
    required String name,
    required int attackValue,
    required String debuffName,
    required int debuffStacks,
    String description = '',
  }) : this(
          type: 'attack_debuff',
          name: name,
          description: description.isNotEmpty
              ? description
              : 'Deals $attackValue damage and applies $debuffStacks $debuffName',
          value: attackValue,
          isMultiAttack: false,
          attackValue: attackValue,
          debuffName: debuffName,
          debuffStacks: debuffStacks,
          healAmount: null,
          blockAmount: null,
        );

  EnemyIntent.special({
    required String name,
    required String description,
    required int value,
    bool isMultiAttack = false,
    int? healAmount,
    int? blockAmount,
  }) : this(
          type: 'special',
          name: name,
          description: description,
          value: value,
          isMultiAttack: isMultiAttack,
          attackValue: value > 0 ? value : null,
          debuffName: null,
          debuffStacks: null,
          healAmount: healAmount,
          blockAmount: blockAmount,
        );

  // Costruttore privato completo
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

  // Helper per logica di gioco (nessuna dipendenza UI)
  bool get isAttack => type == 'attack' || type == 'attack_debuff' || (attackValue != null && attackValue! > 0);
  bool get appliesDebuff => debuffName != null && debuffStacks != null && debuffStacks! > 0;
  bool get isHeal => healAmount != null && healAmount! > 0;
  bool get isBlock => blockAmount != null && blockAmount! > 0;
}