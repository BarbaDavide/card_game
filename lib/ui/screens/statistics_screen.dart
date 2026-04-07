import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/providers/statistics_provider.dart';
import '../../l10n/l10n.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statisticsProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A12),
      appBar: AppBar(
        title: Text(l10n.statisticsTitle),
        backgroundColor: const Color(0xFF121225),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(l10n.generalStats),
            _buildStatCard(
              icon: Icons.play_circle_outline,
              label: 'Total Runs',
              value: stats['totalRuns'].toString(),
              color: const Color(0xFF6C63FF),
            ),
            _buildStatRow(
              icon: Icons.emoji_events,
              label: 'Wins',
              value: stats['wins'].toString(),
              color: Colors.green,
            ),
            _buildStatRow(
              icon: Icons.cancel_outlined,
              label: 'Losses',
              value: stats['losses'].toString(),
              color: Colors.red,
            ),
            _buildWinRateCard(stats),
            
            const SizedBox(height: 24),
            _buildSectionHeader('Combat'),
            _buildStatCard(
              icon: Icons.swords,
              label: 'Total Battles',
              value: stats['totalBattles'].toString(),
              color: const Color(0xFFFF6B6B),
            ),
            _buildStatRow(
              icon: Icons.shield_outlined,
              label: 'Enemies Defeated',
              value: stats['enemiesDefeated'].toString(),
              color: const Color(0xFF4ECDC4),
            ),
            _buildStatRow(
              icon: Icons.crown,
              label: 'Bosses Defeated',
              value: stats['bossesDefeated'].toString(),
              color: const Color(0xFFFFD93D),
            ),
            
            const SizedBox(height: 24),
            _buildSectionHeader('Collection'),
            _buildStatCard(
              icon: Icons.collections_bookmark,
              label: 'Cards Collected',
              value: stats['cardsCollected'].toString(),
              color: const Color(0xFFA78BFA),
            ),
            _buildStatRow(
              icon: Icons.attach_money,
              label: 'Total Gold Earned',
              value: stats['totalGoldEarned'].toString(),
              color: const Color(0xFFFFD700),
            ),
            
            const SizedBox(height: 24),
            _buildSectionHeader('Progress'),
            _buildStatCard(
              icon: Icons.layers,
              label: 'Highest Floor',
              value: stats['highestFloor'].toString(),
              color: const Color(0xFF00D9FF),
            ),
            _buildStatRow(
              icon: Icons.emoji_events_outlined,
              label: 'Achievements',
              value: stats['achievementsUnlocked'].toString(),
              color: const Color(0xFFFF6B9D),
            ),
            
            const SizedBox(height: 24),
            _buildSectionHeader('Time'),
            _buildPlayTimeCard(stats),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00D9FF),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      color: const Color(0xFF1A1A2E).withOpacity(0.6),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
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

  Widget _buildStatRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      color: const Color(0xFF121225).withOpacity(0.4),
      margin: const EdgeInsets.only(bottom: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWinRateCard(Map<String, dynamic> stats) {
    final wins = stats['wins'] as int? ?? 0;
    final losses = stats['losses'] as int? ?? 0;
    final total = wins + losses;
    final winRate = total > 0 ? (wins / total * 100) : 0.0;

    return Card(
      color: const Color(0xFF1A1A2E).withOpacity(0.6),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.show_chart, color: Color(0xFF6C63FF)),
                const SizedBox(width: 12),
                Text(
                  'Win Rate',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${winRate.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$total games',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: winRate / 100,
                backgroundColor: Colors.grey[800],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6C63FF),
                ),
                minHeight: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayTimeCard(Map<String, dynamic> stats) {
    final seconds = stats['playTimeSeconds'] as int? ?? 0;
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;

    return Card(
      color: const Color(0xFF1A1A2E).withOpacity(0.6),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF00D9FF).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.access_time, color: Color(0xFF00D9FF), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Play Time',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${hours}h ${minutes}m',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
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
}
