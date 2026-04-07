// lib/data/achievements_database.dart

import '../domain/models/achievement.dart';
import 'package:flutter/material.dart';

class AchievementsDatabase {
  static final List<Achievement> all = [
    // GAMEPLAY
    const Achievement(
      id: 'first_run',
      titleKey: 'achievement_first_run_title',
      descriptionKey: 'achievement_first_run_desc',
      category: AchievementCategory.gameplay,
      progressGoal: 1,
      icon: Icons.flag,
    ),
    const Achievement(
      id: 'win_first_game',
      titleKey: 'achievement_win_first_game_title',
      descriptionKey: 'achievement_win_first_game_desc',
      category: AchievementCategory.gameplay,
      progressGoal: 1,
      prerequisiteIds: ['first_run'],
      icon: Icons.emoji_events,
    ),
    const Achievement(
      id: 'complete_10_runs',
      titleKey: 'achievement_complete_10_runs_title',
      descriptionKey: 'achievement_complete_10_runs_desc',
      category: AchievementCategory.gameplay,
      progressGoal: 10,
      icon: Icons.run_circle,
    ),
    const Achievement(
      id: 'reach_floor_10',
      titleKey: 'achievement_reach_floor_10_title',
      descriptionKey: 'achievement_reach_floor_10_desc',
      category: AchievementCategory.gameplay,
      progressGoal: 1,
      icon: Icons.layers,
    ),
    const Achievement(
      id: 'reach_floor_20',
      titleKey: 'achievement_reach_floor_20_title',
      descriptionKey: 'achievement_reach_floor_20_desc',
      category: AchievementCategory.gameplay,
      progressGoal: 1,
      prerequisiteIds: ['reach_floor_10'],
      icon: Icons.layers_outlined,
    ),
    
    // COMBAT
    const Achievement(
      id: 'defeat_10_enemies',
      titleKey: 'achievement_defeat_10_enemies_title',
      descriptionKey: 'achievement_defeat_10_enemies_desc',
      category: AchievementCategory.combat,
      progressGoal: 10,
      icon: Icons.swords,
    ),
    const Achievement(
      id: 'defeat_100_enemies',
      titleKey: 'achievement_defeat_100_enemies_title',
      descriptionKey: 'achievement_defeat_100_enemies_desc',
      category: AchievementCategory.combat,
      progressGoal: 100,
      prerequisiteIds: ['defeat_10_enemies'],
      icon: Icons.battle,
    ),
    const Achievement(
      id: 'defeat_boss',
      titleKey: 'achievement_defeat_boss_title',
      descriptionKey: 'achievement_defeat_boss_desc',
      category: AchievementCategory.combat,
      progressGoal: 1,
      icon: Icons.dangerous,
    ),
    const Achievement(
      id: 'perfect_battle',
      titleKey: 'achievement_perfect_battle_title',
      descriptionKey: 'achievement_perfect_battle_desc',
      category: AchievementCategory.combat,
      progressGoal: 1,
      icon: Icons.shield,
    ),
    const Achievement(
      id: 'deal_1000_damage',
      titleKey: 'achievement_deal_1000_damage_title',
      descriptionKey: 'achievement_deal_1000_damage_desc',
      category: AchievementCategory.combat,
      progressGoal: 1000,
      icon: Icons.flash_on,
    ),
    
    // COLLECTION
    const Achievement(
      id: 'collect_10_cards',
      titleKey: 'achievement_collect_10_cards_title',
      descriptionKey: 'achievement_collect_10_cards_desc',
      category: AchievementCategory.collection,
      progressGoal: 10,
      icon: Icons.collections,
    ),
    const Achievement(
      id: 'collect_50_cards',
      titleKey: 'achievement_collect_50_cards_title',
      descriptionKey: 'achievement_collect_50_cards_desc',
      category: AchievementCategory.collection,
      progressGoal: 50,
      prerequisiteIds: ['collect_10_cards'],
      icon: Icons.collections_bookmark,
    ),
    const Achievement(
      id: 'collect_all_cards',
      titleKey: 'achievement_collect_all_cards_title',
      descriptionKey: 'achievement_collect_all_cards_desc',
      category: AchievementCategory.collection,
      progressGoal: 1,
      prerequisiteIds: ['collect_50_cards'],
      icon: Icons.star,
    ),
    const Achievement(
      id: 'upgrade_card',
      titleKey: 'achievement_upgrade_card_title',
      descriptionKey: 'achievement_upgrade_card_desc',
      category: AchievementCategory.collection,
      progressGoal: 1,
      icon: Icons.arrow_upward,
    ),
    
    // STORY
    const Achievement(
      id: 'meet_merchant',
      titleKey: 'achievement_meet_merchant_title',
      descriptionKey: 'achievement_meet_merchant_desc',
      category: AchievementCategory.story,
      progressGoal: 1,
      icon: Icons.store,
    ),
    const Achievement(
      id: 'unlock_all_characters',
      titleKey: 'achievement_unlock_all_characters_title',
      descriptionKey: 'achievement_unlock_all_characters_desc',
      category: AchievementCategory.story,
      progressGoal: 1,
      icon: Icons.people,
    ),
    
    // CHALLENGE
    const Achievement(
      id: 'win_without_damage',
      titleKey: 'achievement_win_without_damage_title',
      descriptionKey: 'achievement_win_without_damage_desc',
      category: AchievementCategory.challenge,
      progressGoal: 1,
      icon: Icons.local_fire_department,
    ),
    const Achievement(
      id: 'speed_run',
      titleKey: 'achievement_speed_run_title',
      descriptionKey: 'achievement_speed_run_desc',
      category: AchievementCategory.challenge,
      progressGoal: 1,
      icon: Icons.timer,
    ),
    const Achievement(
      id: 'hard_mode_victory',
      titleKey: 'achievement_hard_mode_victory_title',
      descriptionKey: 'achievement_hard_mode_victory_desc',
      category: AchievementCategory.challenge,
      progressGoal: 1,
      prerequisiteIds: ['win_first_game'],
      icon: Icons.psychology,
    ),
  ];
  
  static List<Achievement> getByCategory(AchievementCategory category) {
    return all.where((a) => a.category == category).toList();
  }
  
  static Achievement? getById(String id) {
    try {
      return all.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }
}
