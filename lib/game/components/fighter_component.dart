// lib/components/fighter_component.dart

import 'package:flutter/material.dart';

class FighterComponent extends StatelessWidget {
  final String name;
  final int currentHp;
  final int maxHp;
  final int? currentBlock; // Opzionale: block attuale

  const FighterComponent({
    Key? key,
    required this.name,
    required this.currentHp,
    required this.maxHp,
    this.currentBlock,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hpPercent = currentHp / maxHp;
    final hpColor = _getHpColor(hpPercent);

    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hpColor.withOpacity(0.7),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nome fighter
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          
          // Barra HP
          Container(
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFF4A4A5A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FractionallySizedBox(
              widthFactor: hpPercent,
              child: Container(
                decoration: BoxDecoration(
                  color: hpColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          
          // Testo HP
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HP: $currentHp/$maxHp',
                style: TextStyle(
                  color: hpColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (currentBlock != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4FC3F7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Block: $currentBlock',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getHpColor(double percent) {
    if (percent > 0.6) return Colors.green;
    if (percent > 0.3) return Colors.yellow;
    return Colors.red;
  }
}