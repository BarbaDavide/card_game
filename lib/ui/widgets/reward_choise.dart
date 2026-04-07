// lib/widgets/reward_choice_widget.dart

import 'package:flutter/material.dart';

class RewardChoiceWidget extends StatelessWidget {
  final List<Map<String, dynamic>> rewards;
  final ValueChanged<int>? onRewardSelected;
  final bool isChoosingCard;
  final String title;

  const RewardChoiceWidget({
    Key? key,
    required this.rewards,
    this.onRewardSelected,
    this.isChoosingCard = true,
    this.title = 'CHOOSE A REWARD',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF4A4A7A), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header con titolo
          _buildHeader(context),
          
          const SizedBox(height: 20),
          
          // Opzioni ricompensa
          if (rewards.length == 3)
            _buildThreeOptions(context)
          else
            _buildVariableOptions(context),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildThreeOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(3, (index) {
        final reward = rewards[index];
        return _buildRewardOption(
          context,
          reward: reward,
          index: index,
          isCenter: index == 1,
          onTap: () => onRewardSelected?.call(index),
        );
      }),
    );
  }

  Widget _buildVariableOptions(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildRewardOption(
              context,
              reward: reward,
              index: index,
              isCenter: false,
              onTap: () => onRewardSelected?.call(index),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRewardOption(
    BuildContext context, {
    required Map<String, dynamic> reward,
    required int index,
    required bool isCenter,
    required VoidCallback onTap,
  }) {
    final type = reward['type'] as String;
    final name = reward['name'] as String;
    final description = reward['description'] as String?;
    final rarity = reward['rarity'] as String?;
    final isGold = type == 'gold';
    final isRelic = type == 'relic';
    
    final color = _getRewardColor(type, rarity);
    final icon = _getRewardIcon(type);
    final emoji = _getRewardEmoji(type);
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 140,
        height: isCenter ? 180 : 160,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A30),
          border: Border.all(
            color: color,
            width: isCenter ? 3 : 2,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: isCenter ? 20 : 12,
              spreadRadius: isCenter ? 3 : 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icona/Emoji grande
            Text(
              isGold ? '💰' : (isRelic ? '⭐' : emoji),
              style: TextStyle(
                fontSize: isCenter ? 48 : 40,
                shadows: [
                  Shadow(
                    color: color.withOpacity(0.8),
                    blurRadius: 12,
                    offset: Offset.zero,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Nome
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: isCenter ? 16 : 14,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Descrizione (solo per carte/reliquie)
            if (description != null && description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getRewardColor(String type, String? rarity) {
    if (type == 'gold') return Colors.amber;
    if (type == 'relic') return Colors.orange;
    if (type == 'card') {
      switch (rarity) {
        case 'common': return Colors.grey;
        case 'uncommon': return Colors.blue;
        case 'rare': return Colors.purple;
        default: return Colors.grey;
      }
    }
    return Colors.green;
  }

  IconData _getRewardIcon(String type) {
    switch (type) {
      case 'gold': return Icons.attach_money;
      case 'card': return Icons.credit_card;
      case 'relic': return Icons.star;
      case 'potion': return Icons.opacity;
      default: return Icons.card_giftcard;
    }
  }

  String _getRewardEmoji(String type) {
    switch (type) {
      case 'card': return '🃏';
      case 'relic': return '⭐';
      case 'potion': return '🧪';
      case 'gold': return '💰';
      default: return '🎁';
    }
  }
}