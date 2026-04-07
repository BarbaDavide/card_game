import 'package:flutter/material.dart';
import '../../ui/theme/app_theme.dart';
import '../../services/sound_manager.dart';

/// Collection Widget - Componente per visualizzare le carte collezionate
class CollectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> cards;
  final Function(Map<String, dynamic>)? onCardTap;

  const CollectionWidget({
    super.key,
    required this.cards,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.65,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return _buildCardItem(context, card);
      },
    );
  }

  Widget _buildCardItem(BuildContext context, Map<String, dynamic> card) {
    final rarity = card['rarity'] ?? 'common';
    Color rarityColor;
    
    switch (rarity.toString().toLowerCase()) {
      case 'legendary':
        rarityColor = AppTheme.accent;
        break;
      case 'rare':
        rarityColor = AppTheme.primary;
        break;
      case 'uncommon':
        rarityColor = AppTheme.success;
        break;
      default:
        rarityColor = AppTheme.textSecondary;
    }

    return GestureDetector(
      onTap: () {
        AppSoundManager().playSFX(SFX.cardDraw);
        if (onCardTap != null) onCardTap!(card);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: rarityColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: rarityColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Card image placeholder
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: rarityColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getCardIcon(card['type']),
                    color: rarityColor,
                    size: 40,
                  ),
                ),
              ),
            ),
            
            // Card info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card['name'] ?? 'Unknown',
                      style: AppTheme.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.bolt,
                          size: 12,
                          color: AppTheme.secondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${card['cost'] ?? 0}',
                          style: AppTheme.caption.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCardIcon(String? type) {
    switch (type?.toString().toLowerCase()) {
      case 'attack':
        return Icons.swords;
      case 'skill':
        return Icons.shield;
      case 'power':
        return Icons.auto_awesome;
      default:
        return Icons.article;
    }
  }
}

/// Stats Widget - Componente per visualizzazione statistiche
class StatsWidget extends StatelessWidget {
  final Map<String, dynamic> stats;

  const StatsWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistiche',
            style: AppTheme.headline3,
          ),
          const SizedBox(height: 16),
          _buildStatRow('Partite giocate', stats['gamesPlayed'] ?? 0),
          _buildStatRow('Vittorie', stats['wins'] ?? 0, valueColor: AppTheme.success),
          _buildStatRow('Sconfitte', stats['losses'] ?? 0, valueColor: AppTheme.error),
          _buildStatRow('Nemici sconfitti', stats['enemiesDefeated'] ?? 0),
          _buildStatRow('Carte collezionate', stats['cardsCollected'] ?? 0),
          _buildStatRow('Run completate', stats['runsCompleted'] ?? 0),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTheme.bodyMedium),
          Text(
            '$value',
            style: AppTheme.bodyLarge.copyWith(
              color: valueColor ?? AppTheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// Reward Widget - Componente per scelta ricompense
class RewardChoiceWidget extends StatelessWidget {
  final List<Map<String, dynamic>> rewards;
  final Function(Map<String, dynamic>) onSelect;

  const RewardChoiceWidget({
    super.key,
    required this.rewards,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: rewards.map((reward) => _buildRewardCard(reward)).toList(),
    );
  }

  Widget _buildRewardCard(Map<String, dynamic> reward) {
    final type = reward['type'] ?? 'card';
    IconData icon;
    String title;
    Color color;

    switch (type.toString().toLowerCase()) {
      case 'card':
        icon = Icons.deck;
        title = reward['cardName'] ?? 'Nuova Carta';
        color = AppTheme.primary;
        break;
      case 'potion':
        icon = Icons.local_drink;
        title = reward['potionName'] ?? 'Pozione';
        color = AppTheme.accent;
        break;
      case 'relic':
        icon = Icons.workspace_premium;
        title = reward['relicName'] ?? 'Reliquia';
        color = AppTheme.warning;
        break;
      case 'gold':
        icon = Icons.attach_money;
        title = '${reward['amount']} Oro';
        color = Colors.amber;
        break;
      default:
        icon = Icons.card_giftcard;
        title = 'Ricompensa';
        color = AppTheme.secondary;
    }

    return GestureDetector(
      onTap: () {
        AppSoundManager().playSFX(SFX.obtainItem);
        onSelect(reward);
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              'Tocca per selezionare',
              style: AppTheme.caption,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
