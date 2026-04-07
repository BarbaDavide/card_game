// lib/components/energy_counter.dart

import 'package:flutter/material.dart';

class EnergyCounter extends StatelessWidget {
  final int current;
  final int max;

  const EnergyCounter({
    Key? key,
    required this.current,
    required this.max,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF1A237E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4FC3F7), width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.bolt,
            size: 20,
            color: const Color(0xFF4FC3F7),
          ),
          const SizedBox(width: 6),
          Text(
            '$current/$max',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monospace',
            ),
          ),
        ],
      ),
    );
  }
}