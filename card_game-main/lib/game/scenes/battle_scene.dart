// lib/scenes/battle_scene.dart

import 'package:flutter/material.dart';

// Componenti necessari (assicurati di averli creati prima)
import '../components/energy_counter.dart';
import '../components/fighter_component.dart';

class BattleScene extends StatefulWidget {
  final String playerName;
  final int playerHp;
  final int playerMaxHp;
  final int playerBlock;
  final int playerEnergy;
  final int playerMaxEnergy;
  final String enemyName;
  final int enemyHp;
  final int enemyMaxHp;
  final String enemyIntent; // "attack", "buff", "debuff"
  final int enemyIntentValue;

  const BattleScene({
    Key? key,
    required this.playerName,
    required this.playerHp,
    required this.playerMaxHp,
    required this.playerBlock,
    required this.playerEnergy,
    required this.playerMaxEnergy,
    required this.enemyName,
    required this.enemyHp,
    required this.enemyMaxHp,
    required this.enemyIntent,
    required this.enemyIntentValue,
  }) : super(key: key);

  @override
  State<BattleScene> createState() => _BattleSceneState();
}

class _BattleSceneState extends State<BattleScene> {
  List<String> hand = [
    'Strike',
    'Strike',
    'Strike',
    'Defend',
    'Bash',
  ];

  int currentEnergy = 3;
  bool isEnemyTurn = false;

  void playCard(String cardName) {
    if (isEnemyTurn) return;
    
    int cost = 1;
    if (cardName == 'Bash') cost = 2;
    if (cardName == 'Defend') cost = 1;
    
    if (currentEnergy >= cost) {
      setState(() {
        currentEnergy -= cost;
        // Logica di gioco della carta (danno/blocco)
        if (cardName == 'Strike') {
          // Infliggi 6 danni
        } else if (cardName == 'Bash') {
          // Infliggi 8 danni + vulnerable
        } else if (cardName == 'Defend') {
          // Guadagna 5 block
        }
      });
    }
  }

  void endTurn() {
    setState(() {
      isEnemyTurn = true;
      currentEnergy = widget.playerMaxEnergy; // Ripristina energia
      
      // Logica turno nemico (semplificata)
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isEnemyTurn = false;
          // Applica danno del nemico al giocatore (simulato)
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // Header: Nemico
            _buildEnemySection(context),
            
            // Spazio di combattimento (vuoto per ora)
            Expanded(
              child: Container(
                color: const Color(0xFF1E1E2E),
                child: const Center(
                  child: Text(
                    'Battlefield',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            
            // Giocatore + Energia
            _buildPlayerSection(context),
            
            // Mana bar + End Turn
            _buildEnergySection(context),
            
            // Mano carte
            _buildHandSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEnemySection(BuildContext context) {
    final hpPercent = widget.enemyHp / widget.enemyMaxHp;
    final intentColor = _getIntentColor(widget.enemyIntent);

    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF2A2A3A),
      child: Column(
        children: [
          // Nome nemico
          Text(
            widget.enemyName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Barra HP
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: const Color(0xFF4A4A5A),
              borderRadius: BorderRadius.circular(6),
            ),
            child: FractionallySizedBox(
              widthFactor: hpPercent.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: hpPercent > 0.5 ? Colors.green : hpPercent > 0.2 ? Colors.yellow : Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          
          // HP testo
          Text(
            '${widget.enemyHp}/${widget.enemyMaxHp} HP',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          
          // Intent (prossima mossa)
          if (widget.enemyIntent.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: intentColor.withOpacity(0.2),
                border: Border.all(color: intentColor, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_getIntentIcon(widget.enemyIntent), color: intentColor, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    _getIntentText(widget.enemyIntent, widget.enemyIntentValue),
                    style: TextStyle(
                      color: intentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlayerSection(BuildContext context) {
    return FighterComponent(
      name: widget.playerName,
      currentHp: widget.playerHp,
      maxHp: widget.playerMaxHp,
      currentBlock: widget.playerBlock,
    );
  }

  Widget _buildEnergySection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF1A1A2A),
      child: Row(
        children: [
          // Contatore energia
          EnergyCounter(
            current: currentEnergy,
            max: widget.playerMaxEnergy,
          ),
          const Spacer(),
          
          // Bottone End Turn
          ElevatedButton(
            onPressed: isEnemyTurn ? null : endTurn,
            style: ElevatedButton.styleFrom(
              backgroundColor: isEnemyTurn ? Colors.grey : Colors.orange,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: isEnemyTurn
                ? const Text('ENEMY TURN...', style: TextStyle(fontWeight: FontWeight.bold))
                : const Text('END TURN', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildHandSection(BuildContext context) {
    return Container(
      height: 140,
      color: const Color(0xFF151520),
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hand.length,
        itemBuilder: (context, index) {
          final cardName = hand[index];
          final isPlayable = _getCardCost(cardName) <= currentEnergy;
          
          return GestureDetector(
            onTap: isPlayable ? () => playCard(cardName) : null,
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              width: 100,
              decoration: BoxDecoration(
                color: isPlayable ? Colors.blueGrey : Colors.grey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isPlayable ? Colors.blue : Colors.grey,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Costo
                  Container(
                    padding: const EdgeInsets.all(4),
                    color: isPlayable ? Colors.blue : Colors.grey[700],
                    child: Text(
                      _getCardCost(cardName).toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Nome
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      cardName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  // Tipo
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(
                      cardName == 'Defend' ? 'SKILL' : 'ATTACK',
                      style: TextStyle(
                        color: cardName == 'Defend' ? Colors.green : Colors.red,
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
    );
  }

  int _getCardCost(String cardName) {
    if (cardName == 'Bash') return 2;
    return 1;
  }

  Color _getIntentColor(String intent) {
    switch (intent) {
      case 'attack':
        return Colors.red;
      case 'buff':
        return Colors.blue;
      case 'debuff':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getIntentIcon(String intent) {
    switch (intent) {
      case 'attack':
        return Icons.flash_on;
      case 'buff':
        return Icons.shield;
      case 'debuff':
        return Icons.exposure_neg_1;
      default:
        return Icons.help_outline;
    }
  }

  String _getIntentText(String intent, int value) {
    switch (intent) {
      case 'attack':
        return 'Attack $value';
      case 'buff':
        return 'Buff (+$value)';
      case 'debuff':
        return 'Debuff (-$value)';
      default:
        return 'Unknown';
    }
  }
}