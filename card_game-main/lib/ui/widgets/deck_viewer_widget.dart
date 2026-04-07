// lib/widgets/deck_viewer_widget.dart

import 'package:flutter/material.dart';

class DeckViewerWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cards;
  final bool showCounts;

  const DeckViewerWidget({
    Key? key,
    required this.cards,
    this.showCounts = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151525),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3A3A5A), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E35),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(Icons.deck, color: Colors.blue, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Deck (${cards.length} cards)',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getTotalCostColor(cards),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_calculateTotalCost(cards)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Cards grid
          Expanded(
            child: cards.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return _buildCardTile(card, showCounts ? _getCardCount(cards, card['name'] as String) : null);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardTile(Map<String, dynamic> card, int? count) {
    final name = card['name'] as String;
    final cost = card['cost'] as int;
    final type = card['type'] as String;
    final rarity = card['rarity'] as String;
    final description = card['description'] as String;
    
    final typeColor = _getCardTypeColor(type);
    final rarityColor = _getRarityColor(rarity);
    final costColor = _getCostColor(cost);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF222238),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: rarityColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: typeColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cost in top right
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: costColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$cost',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          // Card name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Description
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  height: 1.3,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          
          // Footer: type + count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: typeColor.withOpacity(0.15),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _getCardTypeLabel(type),
                    style: TextStyle(
                      color: typeColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                if (count != null && count > 1)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A4A6A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'x$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.deck_outlined,
            size: 64,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'Empty Deck',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add cards to build your deck',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCardTypeColor(String type) {
    switch (type) {
      case 'attack': return Colors.red;
      case 'skill': return Colors.green;
      case 'power': return Colors.purple;
      default: return Colors.grey;
    }
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case 'common': return Colors.grey;
      case 'uncommon': return Colors.blue;
      case 'rare': return Colors.orange;
      default: return Colors.grey;
    }
  }

  Color _getCostColor(int cost) {
    if (cost == 0) return Colors.cyan;
    if (cost <= 1) return Colors.blue;
    if (cost <= 2) return Colors.green;
    return Colors.red;
  }

  String _getCardTypeLabel(String type) {
    switch (type) {
      case 'attack': return 'ATTACK';
      case 'skill': return 'SKILL';
      case 'power': return 'POWER';
      default: return type.toUpperCase();
    }
  }

  int _calculateTotalCost(List<Map<String, dynamic>> cards) {
    return cards.fold(0, (sum, card) => sum + (card['cost'] as int));
  }

  Color _getTotalCostColor(List<Map<String, dynamic>> cards) {
    final total = _calculateTotalCost(cards);
    if (total < 20) return Colors.green;
    if (total < 35) return Colors.yellow;
    return Colors.orange;
  }

  int _getCardCount(List<Map<String, dynamic>> cards, String cardName) {
    return cards.where((card) => card['name'] == cardName).length;
  }
}