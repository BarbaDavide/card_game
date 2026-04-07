// lib/ui/screen/battle_screen.dart

import 'package:flutter/material.dart';
import 'dart:math';

// ===== CLASSE MINIMALE PER INTENTI NEMICI (INTEGRATA) =====
class EnemyIntent {
  final String type;
  final String name;
  final String description;
  final int value;
  final bool isMultiAttack;
  final int? attackValue;
  final String? debuffName;
  final int? debuffStacks;
  final int? healAmount;
  final int? blockAmount;

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
}

// ===== COMPONENTE NEMICO MINIMALE (INTEGRATO) =====
class _EnemyComponent extends StatelessWidget {
  final String name;
  final String description;
  final double hpPercent;
  final int currentHp;
  final int maxHp;
  final String intentName;
  final String intentDescription;
  final int intentValue;
  final String intentType;
  final bool isElite;
  final bool isBoss;

  const _EnemyComponent({
    required this.name,
    required this.description,
    required this.hpPercent,
    required this.currentHp,
    required this.maxHp,
    required this.intentName,
    required this.intentDescription,
    required this.intentValue,
    required this.intentType,
    required this.isElite,
    required this.isBoss,
  });

  @override
  Widget build(BuildContext context) {
    final hpColor = hpPercent > 0.6 ? Colors.green : hpPercent > 0.3 ? Colors.yellow : Colors.red;
    final borderColor = isBoss ? Colors.red : isElite ? Colors.purple : Colors.blue;
    final bgColor = isBoss ? Color(0xFF2A0A0A) : isElite ? Color(0xFF1A0A2A) : Color(0xFF151525);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: isBoss ? 3 : isElite ? 2 : 1),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A2A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                if (isBoss) _buildBadge('BOSS', Colors.red),
                if (isElite && !isBoss) _buildBadge('ELITE', Colors.purple),
                Spacer(),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isBoss ? 24 : 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                if (isBoss) _buildBadge('BOSS', Colors.red),
              ],
            ),
          ),
          
          // Silhouette nemico
          Container(
            height: 120,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 15,
                          left: 20,
                          child: Container(
                            width: 20,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 15,
                          child: Container(
                            width: 30,
                            height: 35,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        if (isElite || isBoss)
                          Positioned(
                            top: 50,
                            left: 25,
                            child: Container(
                              width: 10,
                              height: 20,
                              color: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    isBoss ? 'GLOBAL POWER' : isElite ? 'POWER BROKER' : 'POLITICIAN',
                    style: TextStyle(
                      color: borderColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Barra HP
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFF3A3A4A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: hpPercent.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: hpColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '$currentHp/$maxHp HP',
                  style: TextStyle(
                    color: hpColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Descrizione
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.3),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Intento
          if (intentName.isNotEmpty) ...[
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getIntentColor(intentType).withOpacity(0.15),
                border: Border.all(color: _getIntentColor(intentType), width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_getIntentIcon(intentType), size: 20, color: _getIntentColor(intentType)),
                      SizedBox(width: 8),
                      Text(
                        intentName.toUpperCase(),
                        style: TextStyle(
                          color: _getIntentColor(intentType),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    intentDescription,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getIntentColor(String type) {
    switch (type) {
      case 'attack': return Colors.red;
      case 'debuff': return Colors.orange;
      case 'special': return Colors.purple;
      default: return Colors.grey;
    }
  }

  IconData _getIntentIcon(String type) {
    switch (type) {
      case 'attack': return Icons.flash_on;
      case 'debuff': return Icons.exposure_neg_1;
      case 'special': return Icons.auto_awesome;
      default: return Icons.help_outline;
    }
  }
}

// ===== SCHERMATA DI COMBATTIMENTO COMPLETA =====
class BattleScreen extends StatefulWidget {
  final String enemyId;
  final String enemyName;
  final String enemyDescription;
  final int enemyMaxHp;
  final bool isElite;
  final bool isBoss;

  const BattleScreen({
    Key? key,
    required this.enemyId,
    required this.enemyName,
    required this.enemyDescription,
    required this.enemyMaxHp,
    required this.isElite,
    required this.isBoss,
  }) : super(key: key);

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  // STATO GIOCATORE
  int playerHp = 66;
  int playerMaxHp = 66;
  int playerBlock = 0;
  int playerEnergy = 3;
  int playerMaxEnergy = 3;
  List<String> hand = ['strike', 'strike', 'strike', 'defend', 'bash'];

  // STATO NEMICO
  int enemyHp = 0;
  EnemyIntent? currentIntent;
  bool isFirstTurn = true;
  final Random _random = Random();

  // STATO COMBATTIMENTO
  bool isPlayerTurn = true;
  bool isCombatOver = false;

  @override
  void initState() {
    super.initState();
    enemyHp = widget.enemyMaxHp;
    _determineEnemyIntent();
  }

  void _determineEnemyIntent() {
    // AI SEMPLIFICATA INTEGRATA (nessuna dipendenza esterna)
    EnemyIntent intent;
    final roll = _random.nextInt(10);
    
    if (widget.enemyId.contains('trump')) {
      intent = roll < 4 
        ? EnemyIntent(type: 'attack', name: 'Fake News', description: 'Chaotic misinformation attack', value: 14, isMultiAttack: false, attackValue: 14)
        : EnemyIntent(type: 'special', name: 'Twitter Storm', description: 'Unleashes viral chaos', value: 10, isMultiAttack: true);
    } else if (widget.enemyId.contains('putin')) {
      intent = roll < 5
        ? EnemyIntent(type: 'attack', name: 'Cyber Attack', description: 'Precision digital strike', value: 16, isMultiAttack: false, attackValue: 16)
        : EnemyIntent(type: 'debuff', name: 'Energy Blackmail', description: 'Applies Vulnerable', value: 0, isMultiAttack: false, debuffName: 'Vulnerable', debuffStacks: 2);
    } else if (widget.enemyId.contains('musk')) {
      intent = roll < 3
        ? EnemyIntent(type: 'attack', name: 'Rocket Barrage', description: 'Multiple rocket strikes', value: 18, isMultiAttack: true, attackValue: 18)
        : EnemyIntent(type: 'attack', name: 'Flamethrower', description: 'Direct flame attack', value: 12, isMultiAttack: false, attackValue: 12);
    } else {
      // Nemico generico
      intent = EnemyIntent(
        type: 'attack',
        name: 'Political Attack',
        description: 'Standard political maneuver',
        value: 10,
        isMultiAttack: false,
        attackValue: 10,
      );
    }
    
    setState(() {
      currentIntent = intent;
      isFirstTurn = false;
    });
  }

  void _playCard(String cardId) {
    if (!isPlayerTurn || isCombatOver) return;
    
    final card = _getCardById(cardId);
    final cost = card['cost'] as int;
    if (playerEnergy < cost) return;
    
    setState(() {
      playerEnergy -= cost;
      
      if (card['type'] == 'attack') {
        _applyDamageToEnemy(card['damage'] as int);
      } else if (card['type'] == 'skill' && card.containsKey('block')) {
        playerBlock += card['block'] as int;
      }
      
      hand.remove(cardId);
      if (hand.isEmpty) hand = ['strike', 'strike', 'defend', 'defend', 'bash'];
    });
    
    if (enemyHp <= 0) _endCombat(victory: true);
  }

  void _endTurn() {
    if (!isPlayerTurn || isCombatOver) return;
    
    setState(() {
      isPlayerTurn = false;
      playerBlock = 0;
      playerEnergy = playerMaxEnergy;
    });
    
    Future.delayed(Duration(milliseconds: 800), _executeEnemyTurn);
  }

  void _executeEnemyTurn() {
    if (isCombatOver || currentIntent == null) return;
    
    final intent = currentIntent!;
    if (intent.attackValue != null) {
      _applyDamageToPlayer(intent.attackValue!);
    }
    
    if (playerHp <= 0) {
      _endCombat(victory: false);
      return;
    }
    
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        isPlayerTurn = true;
        playerEnergy = playerMaxEnergy;
      });
      _determineEnemyIntent();
    });
  }

  void _applyDamageToEnemy(int damage) {
    setState(() {
      enemyHp = (enemyHp - damage).clamp(0, widget.enemyMaxHp);
    });
  }

  void _applyDamageToPlayer(int rawDamage) {
    int actualDamage = rawDamage;
    if (playerBlock > 0) {
      final blocked = playerBlock < actualDamage ? playerBlock : actualDamage;
      actualDamage -= blocked;
      setState(() {
        playerBlock = (playerBlock - blocked).clamp(0, 999);
      });
    }
    if (actualDamage > 0) {
      setState(() {
        playerHp = (playerHp - actualDamage).clamp(0, playerMaxHp);
      });
    }
  }

  void _endCombat({required bool victory}) {
    setState(() {
      isCombatOver = true;
    });
    
    Future.delayed(Duration(seconds: 2), () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xFF1A1A2A),
          title: Text(
            victory ? 'VICTORY!' : 'DEFEAT',
            style: TextStyle(
              color: victory ? Colors.green : Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                victory
                    ? 'You defeated ${widget.enemyName}!'
                    : '${widget.enemyName} has defeated you.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 16),
              if (victory) ...[
                Text('Rewards:', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                _buildRewardItem('Common Card', '🃏'),
                SizedBox(height: 4),
                _buildRewardItem('50 Euros', '💶'),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, victory);
              },
              child: Text(
                'CONTINUE',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRewardItem(String text, String emoji) {
    return Row(
      children: [
        Text(emoji, style: TextStyle(fontSize: 20)),
        SizedBox(width: 8),
        Text(text, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Map<String, dynamic> _getCardById(String id) {
    switch (id) {
      case 'strike': return {'name': 'Strike', 'type': 'attack', 'damage': 6, 'cost': 1, 'description': 'Deal 6 damage.'};
      case 'defend': return {'name': 'Defend', 'type': 'skill', 'block': 5, 'cost': 1, 'description': 'Gain 5 block.'};
      case 'bash': return {'name': 'Bash', 'type': 'attack', 'damage': 8, 'block': 2, 'cost': 2, 'description': 'Deal 8 damage. Gain 2 block.'};
      default: return {'name': 'Unknown', 'type': 'attack', 'damage': 5, 'cost': 1, 'description': 'Unknown card'};
    }
  }

  @override
  Widget build(BuildContext context) {
    final hpPercent = enemyHp / widget.enemyMaxHp;
    final playerHpPercent = playerHp / playerMaxHp;
    final hpColor = playerHpPercent > 0.6 ? Colors.green : playerHpPercent > 0.3 ? Colors.yellow : Colors.red;

    return Scaffold(
      backgroundColor: Color(0xFF0A0A15),
      appBar: AppBar(
        backgroundColor: Color(0xFF121225),
        title: Text(
          widget.isBoss ? 'BOSS: ${widget.enemyName}' : 
          widget.isElite ? 'ELITE: ${widget.enemyName}' : widget.enemyName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Column(
        children: [
          // NEMICO
          Container(
            height: 280,
            padding: EdgeInsets.all(16),
            child: _EnemyComponent(
              name: widget.enemyName,
              description: widget.enemyDescription,
              hpPercent: hpPercent,
              currentHp: enemyHp,
              maxHp: widget.enemyMaxHp,
              intentName: currentIntent?.name ?? 'Calculating...',
              intentDescription: currentIntent?.description ?? 'Preparing next move',
              intentValue: currentIntent?.value ?? 0,
              intentType: currentIntent?.type ?? 'none',
              isElite: widget.isElite,
              isBoss: widget.isBoss,
            ),
          ),
          
          // BATTLEFIELD
          Expanded(
            child: Container(
              color: Color(0xFF151525),
              child: Center(
                child: Text(
                  'BATTLEFIELD',
                  style: TextStyle(color: Colors.white38, fontSize: 20, letterSpacing: 2),
                ),
              ),
            ),
          ),
          
          // STATISTICHE GIOCATORE
          Container(
            color: Color(0xFF1A1A2A),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                  Icon(Icons.favorite, color: hpColor, size: 24),
                  SizedBox(height: 4),
                  Text('$playerHp/$playerMaxHp', style: TextStyle(color: hpColor, fontWeight: FontWeight.bold)),
                ]),
                Column(children: [
                  Icon(Icons.shield, color: Colors.blue, size: 24),
                  SizedBox(height: 4),
                  Text(playerBlock.toString(), style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ]),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isPlayerTurn ? Colors.green : Colors.red).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isPlayerTurn ? 'YOUR TURN' : 'ENEMY TURN',
                    style: TextStyle(
                      color: isPlayerTurn ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // MANA BAR
          Container(
            color: Color(0xFF151525),
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Row(
                  children: List.generate(playerMaxEnergy, (i) => 
                    Icon(Icons.bolt, size: 20, color: i < playerEnergy ? Colors.yellow : Colors.grey)
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: isCombatOver ? null : _endTurn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPlayerTurn ? Colors.green : Colors.grey,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    isPlayerTurn ? 'END TURN' : 'WAITING...',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          
          // MANO CARTE
          Container(
            height: 140,
            color: Color(0xFF101018),
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hand.length,
              itemBuilder: (context, index) {
                final card = _getCardById(hand[index]);
                final cost = card['cost'] as int;
                final isPlayable = isPlayerTurn && playerEnergy >= cost && !isCombatOver;
                
                return GestureDetector(
                  onTap: isPlayable ? () => _playCard(hand[index]) : null,
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    width: 110,
                    decoration: BoxDecoration(
                      color: isPlayable ? Color(0xFF2A2A40) : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isPlayable ? Colors.blue : Colors.grey, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              color: isPlayable ? Colors.blue : Colors.grey[700],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              cost.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            card['name'] as String,
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              card['description'] as String,
                              style: TextStyle(color: Colors.white70, fontSize: 11),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          color: (card['type'] as String) == 'attack' 
                              ? Colors.red.withOpacity(0.2) 
                              : Colors.green.withOpacity(0.2),
                          child: Text(
                            (card['type'] as String).toUpperCase(),
                            style: TextStyle(
                              color: (card['type'] as String) == 'attack' ? Colors.red : Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}              