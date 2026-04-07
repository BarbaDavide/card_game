// lib/data/enemy_database.dart

import '../domain/models/enemy.dart';

/// Database completo di nemici satirici-politici
class EnemyDatabase {
  // Singleton
  static final EnemyDatabase _instance = EnemyDatabase._internal();
  factory EnemyDatabase() => _instance;
  EnemyDatabase._internal();

  // ===== NEMICI NORMALI (Act 1: The Political Arena) =====
  
  // Politico locale
  final Enemy localPolitician = Enemy.full(
    id: 'local_politician',
    name: 'Local Politician',
    description: 'A small-time politician looking to climb the ladder',
    type: EnemyType.normal,
    maxHp: 40,
    damage: 6,
    imageUrl: 'local_politician',
    theme: 'politics',
  );

  // Lobbyista
  final Enemy lobbyist = Enemy.full(
    id: 'lobbyist',
    name: 'Corporate Lobbyist',
    description: 'Represents special interests with deep pockets',
    type: EnemyType.normal,
    maxHp: 45,
    damage: 8,
    imageUrl: 'lobbyist',
    theme: 'corporate',
  );

  // Commentatore TV
  final Enemy tvPundit = Enemy.full(
    id: 'tv_pundit',
    name: 'TV Pundit',
    description: 'Shouts opinions and confuses the masses',
    type: EnemyType.normal,
    maxHp: 35,
    damage: 7,
    imageUrl: 'tv_pundit',
    theme: 'media',
  );

  // Burocrate
  final Enemy bureaucrat = Enemy.full(
    id: 'bureaucrat',
    name: 'Government Bureaucrat',
    description: 'Slows everything down with red tape',
    type: EnemyType.normal,
    maxHp: 50,
    damage: 5,
    imageUrl: 'bureaucrat',
    theme: 'government',
  );

  // ===== NEMICI ELITE (Personaggi Riconoscibili) =====
  
  // ELON MUSK
  final Enemy elonMusk = Enemy.full(
    id: 'elon_musk',
    name: 'Elon Musk',
    description: 'Tech billionaire with Twitter army and flamethrowers',
    type: EnemyType.elite,
    maxHp: 120,
    damage: 12,
    imageUrl: 'elon_musk',
    theme: 'tech',
    powers: ['Multi-Attack', 'Tech Disruption'],
  );

  // BILL GATES
  final Enemy billGates = Enemy.full(
    id: 'bill_gates',
    name: 'Bill Gates',
    description: 'Philanthropist with global health influence',
    type: EnemyType.elite,
    maxHp: 110,
    damage: 10,
    imageUrl: 'bill_gates',
    theme: 'health',
    powers: ['Vaccine Mandate', 'Mosquito Swarm'],
  );

  // MARK ZUCKERBERG
  final Enemy markZuckerberg = Enemy.full(
    id: 'mark_zuckerberg',
    name: 'Mark Zuckerberg',
    description: 'Meta overlord controlling the digital public square',
    type: EnemyType.elite,
    maxHp: 100,
    damage: 9,
    imageUrl: 'mark_zuckerberg',
    theme: 'social_media',
    powers: ['Algorithm Manipulation', 'Data Harvesting'],
  );

  // JEFF BEZOS
  final Enemy jeffBezos = Enemy.full(
    id: 'jeff_bezos',
    name: 'Jeff Bezos',
    description: 'E-commerce emperor with space ambitions',
    type: EnemyType.elite,
    maxHp: 115,
    damage: 11,
    imageUrl: 'jeff_bezos',
    theme: 'commerce',
    powers: ['Delivery Drones', 'Blue Origin Lasers'],
  );

  // THE DESERT FOX (Netanyahu parody)
  final Enemy desertFox = Enemy.full(
    id: 'desert_fox',
    name: 'The Desert Fox',
    description: 'Middle East strategist with Iron Dome defenses',
    type: EnemyType.elite,
    maxHp: 125,
    damage: 13,
    imageUrl: 'desert_fox',
    theme: 'military',
    powers: ['Iron Dome', 'Targeted Strike'],
  );

  // GEORGE SOROS
  final Enemy georgeSoros = Enemy.full(
    id: 'george_soros',
    name: 'George Soros',
    description: 'Global financier funding color revolutions',
    type: EnemyType.elite,
    maxHp: 95,
    damage: 8,
    imageUrl: 'george_soros',
    theme: 'finance',
    powers: ['Currency Manipulation', 'NGO Swarm'],
  );

  // KLAUS SCHWAB
  final Enemy klausSchwab = Enemy.full(
    id: 'klaus_schwab',
    name: 'Klaus Schwab',
    description: 'Architect of the Great Reset',
    type: EnemyType.elite,
    maxHp: 105,
    damage: 10,
    imageUrl: 'klaus_schwab',
    theme: 'globalist',
    powers: ['Stakeholder Capitalism', 'Digital ID'],
  );

  // RUPERT MURDOCH
  final Enemy rupertMurdoch = Enemy.full(
    id: 'rupert_murdoch',
    name: 'Rupert Murdoch',
    description: 'Media mogul controlling global narratives',
    type: EnemyType.elite,
    maxHp: 110,
    damage: 11,
    imageUrl: 'rupert_murdoch',
    theme: 'media_empire',
    powers: ['Propaganda Wave', 'News Cycle'],
  );

  // ===== BOSS (Leader Mondiali) =====
  
  // DONALD TRUMP (Boss Act 1)
  final Enemy donaldTrump = Enemy.full(
    id: 'donald_trump',
    name: 'DonaldTrump',
    description: 'The unpredictable leader who dominates media cycles',
    type: EnemyType.boss,
    maxHp: 300,
    damage: 15,
    imageUrl: 'donald_trump',
    theme: 'chaos',
    powers: ['Fake News', 'Twitter Storm', 'Reality Distortion'],
  );

  // VLADIMIR PUTIN (Boss Act 2)
  final Enemy vladimirPutin = Enemy.full(
    id: 'vladimir_putin',
    name: 'VladimirPutin',
    description: 'The calculating strategist who plays the long game',
    type: EnemyType.boss,
    maxHp: 350,
    damage: 18,
    imageUrl: 'vladimir_putin',
    theme: 'ice_cold',
    powers: ['Cyber Warfare', 'Energy Blackmail', 'Bear Hug'],
  );

  // THE PUPPET MASTER (Boss Finale Act 3)
  final Enemy puppetMaster = Enemy.full(
    id: 'puppet_master',
    name: 'ThePuppetMaster',
    description: 'The shadowy figure who pulls all strings worldwide',
    type: EnemyType.boss,
    maxHp: 500,
    damage: 25,
    imageUrl: 'puppet_master',
    theme: 'shadow',
    powers: ['String Pulling', 'Mind Control', 'Reality Rewrite'],
  );

  // ===== METODI DI ACCESSO =====
  
  List<Enemy> get allEnemies => [
        localPolitician,
        lobbyist,
        tvPundit,
        bureaucrat,
        elonMusk,
        billGates,
        markZuckerberg,
        jeffBezos,
        desertFox,
        georgeSoros,
        klausSchwab,
        rupertMurdoch,
        donaldTrump,
        vladimirPutin,
        puppetMaster,
      ];

  Enemy? getEnemyById(String id) {
    for (var enemy in allEnemies) {
      if (enemy.id == id) {
        return enemy;
      }
    }
    return null;
  }

  // Nemici normali casuali per Act 1
  List<Enemy> getNormalEnemies() {
    return [
      localPolitician,
      lobbyist,
      tvPundit,
      bureaucrat,
    ];
  }

  // Elite casuali
  List<Enemy> getEliteEnemies() {
    return [
      elonMusk,
      billGates,
      markZuckerberg,
      jeffBezos,
      desertFox,
      georgeSoros,
      klausSchwab,
      rupertMurdoch,
    ];
  }

  // Boss per ogni atto
  Enemy getBossForAct(int act) {
    switch (act) {
      case 0:
        return donaldTrump;
      case 1:
        return vladimirPutin;
      case 2:
        return puppetMaster;
      default:
        return puppetMaster;
    }
  }
}