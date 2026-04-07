// board_component.dart

import 'package:flutter/material.dart';

/// Componente principale della schermata di gioco
class BoardComponent extends StatelessWidget {
  final String fighterName;
  final int currentHp;
  final int maxHp;
  final int currentMana;
  final int maxMana;
  final int gold;
  final Widget? child; // Contenuto dinamico (combattimento, mappa, ecc.)

  const BoardComponent({
    Key? key,
    required this.fighterName,
    required this.currentHp,
    required this.maxHp,
    required this.currentMana,
    required this.maxMana,
    required this.gold,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          // Barra superiore: statistiche giocatore
          _buildStatsBar(context),
          
          // Contenuto principale (combattimento, mappa, mercante, ecc.)
          Expanded(
            child: child ?? _buildPlaceholder(context),
          ),
          
          // Barra inferiore: azioni rapide
          _buildBottomBar(context),
        ],
      ),
    );
  }

  /// Barra superiore con statistiche
  Widget _buildStatsBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatCard(
            label: fighterName,
            value: '$currentHp/$maxHp',
            icon: Icons.favorite,
            color: Colors.red,
          ),
          _buildStatCard(
            label: 'Mana',
            value: '$currentMana/$maxMana',
            icon: Icons.bolt,
            color: Colors.blue,
          ),
          _buildStatCard(
            label: 'Gold',
            value: '$gold',
            icon: Icons.attach_money,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }

  /// Scheda singola statistica
  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Contenuto principale (placeholder)
  Widget _buildPlaceholder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.gamepad,
            size: 80,
            color: Colors.grey[700],
          ),
          const SizedBox(height: 16),
          Text(
            'Game Board',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Select a node to begin',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  /// Barra inferiore con azioni rapide
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionIcon(Icons.map, 'Map'),
          _buildActionIcon(Icons.deck, 'Deck'),
          _buildActionIcon(Icons.settings, 'Menu'),
        ],
      ),
    );
  }

  /// Icona azione rapida
  Widget _buildActionIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.white),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}