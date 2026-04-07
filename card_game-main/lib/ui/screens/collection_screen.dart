// lib/screens/collection_screen.dart

import 'package:flutter/material.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  String _selectedRarity = 'all';
  String _selectedType = 'all';
  List<String> _searchHistory = [];

  // Dati di esempio (sostituisci con dati reali dal tuo database/stato)
  final List<Map<String, dynamic>> _allCards = [
    {'name': 'Strike', 'type': 'attack', 'rarity': 'common', 'count': 5},
    {'name': 'Defend', 'type': 'skill', 'rarity': 'common', 'count': 4},
    {'name': 'Bash', 'type': 'attack', 'rarity': 'uncommon', 'count': 1},
    {'name': 'Heavy Blade', 'type': 'attack', 'rarity': 'rare', 'count': 1},
    {'name': 'Flex', 'type': 'skill', 'rarity': 'common', 'count': 2},
    {'name': 'Body Slam', 'type': 'attack', 'rarity': 'common', 'count': 1},
    {'name': 'Cloak and Dagger', 'type': 'skill', 'rarity': 'common', 'count': 1},
    {'name': 'Demon Form', 'type': 'power', 'rarity': 'rare', 'count': 1},
    {'name': 'Anger', 'type': 'attack', 'rarity': 'common', 'count': 2},
    {'name': 'Armaments', 'type': 'skill', 'rarity': 'common', 'count': 1},
    {'name': 'Battle Trance', 'type': 'skill', 'rarity': 'uncommon', 'count': 1},
    {'name': 'Berserk', 'type': 'power', 'rarity': 'rare', 'count': 1},
    {'name': 'Blood for Blood', 'type': 'attack', 'rarity': 'uncommon', 'count': 1},
    {'name': 'Bloodletting', 'type': 'skill', 'rarity': 'uncommon', 'count': 1},
    {'name': 'Bludgeon', 'type': 'attack', 'rarity': 'common', 'count': 1},
    {'name': 'Clash', 'type': 'attack', 'rarity': 'uncommon', 'count': 1},
    {'name': 'Cleave', 'type': 'attack', 'rarity': 'common', 'count': 2},
    {'name': 'Clothesline', 'type': 'attack', 'rarity': 'common', 'count': 1},
    {'name': 'Combust', 'type': 'power', 'rarity': 'uncommon', 'count': 1},
    {'name': 'Corruption', 'type': 'power', 'rarity': 'rare', 'count': 1},
  ];

  List<Map<String, dynamic>> get _filteredCards {
    return _allCards.where((card) {
      final matchesRarity = _selectedRarity == 'all' || card['rarity'] == _selectedRarity;
      final matchesType = _selectedType == 'all' || card['type'] == _selectedType;
      return matchesRarity && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Text(
          'Card Collection',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtri
          _buildFilters(context),
          
          // Conteggio carte
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '${_filteredCards.length} cards',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
          
          // Griglia carte
          Expanded(
            child: _filteredCards.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: _filteredCards.length,
                    itemBuilder: (context, index) {
                      final card = _filteredCards[index];
                      return _buildCardTile(card);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF1A1A2A),
      child: Row(
        children: [
          // Filtro rarità
          _buildFilterChip(
            label: 'All',
            isSelected: _selectedRarity == 'all',
            color: Colors.grey,
            onTap: () => setState(() => _selectedRarity = 'all'),
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: 'Common',
            isSelected: _selectedRarity == 'common',
            color: Colors.grey,
            onTap: () => setState(() => _selectedRarity = 'common'),
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: 'Uncommon',
            isSelected: _selectedRarity == 'uncommon',
            color: Colors.blue,
            onTap: () => setState(() => _selectedRarity = 'uncommon'),
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: 'Rare',
            isSelected: _selectedRarity == 'rare',
            color: Colors.orange,
            onTap: () => setState(() => _selectedRarity = 'rare'),
          ),
          const SizedBox(width: 16),
          
          // Filtro tipo
          _buildFilterChip(
            label: '⚔️',
            isSelected: _selectedType == 'attack',
            color: Colors.red,
            onTap: () => setState(() => _selectedType = 'attack'),
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: '🛡️',
            isSelected: _selectedType == 'skill',
            color: Colors.green,
            onTap: () => setState(() => _selectedType = 'skill'),
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: '⚡',
            isSelected: _selectedType == 'power',
            color: Colors.purple,
            onTap: () => setState(() => _selectedType = 'power'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.3) : const Color(0xFF2A2A3A),
          border: Border.all(
            color: isSelected ? color : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? color : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildCardTile(Map<String, dynamic> card) {
    final color = _getRarityColor(card['rarity']);
    final typeEmoji = _getTypeEmoji(card['type']);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A3A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome carta
            Text(
              card['name'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            
            // Tipo + Rarità
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getTypeColor(card['type']).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        typeEmoji,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        card['type'].toUpperCase(),
                        style: TextStyle(
                          color: _getTypeColor(card['type']),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    card['rarity'].toUpperCase(),
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            
            // Conteggio copie
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A4A),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.copy, size: 16, color: Colors.white70),
                  const SizedBox(width: 4),
                  Text(
                    '${card['count']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.collections_bookmark,
            size: 64,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'No cards found',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try changing filters',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E2E),
        title: const Text('Search Cards'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey[500]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3A3A4A)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3A3A4A)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
          ),
          style: const TextStyle(color: Colors.white),
          onSubmitted: (value) {
            if (value.isNotEmpty && !_searchHistory.contains(value)) {
              setState(() {
                _searchHistory.add(value);
              });
            }
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case 'common':
        return Colors.grey;
      case 'uncommon':
        return Colors.blue;
      case 'rare':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'attack':
        return Colors.red;
      case 'skill':
        return Colors.green;
      case 'power':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _getTypeEmoji(String type) {
    switch (type) {
      case 'attack':
        return '⚔️';
      case 'skill':
        return '🛡️';
      case 'power':
        return '⚡';
      default:
        return '❓';
    }
  }
}