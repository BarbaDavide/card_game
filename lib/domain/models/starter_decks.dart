// lib/data/starter_decks.dart

class StarterDecks {
  // ===== CORRUPT POLITICIAN =====
  static List<String> get corruptPoliticianDeck => [
        'backroom_deal', 'backroom_deal', 'backroom_deal', 'backroom_deal', 'backroom_deal',
        'bribe', 'bribe', 'bribe', 'bribe',
        'embezzlement',
      ];

  // ===== ATTACK JOURNALIST =====
  static List<String> get attackJournalistDeck => [
        'fake_news', 'fake_news', 'fake_news', 'fake_news', 'fake_news',
        'leak', 'leak', 'leak', 'leak',
        'sensational_headline',
      ];

  // ===== ACTIVIST =====
  static List<String> get activistDeck => [
        'protest', 'protest', 'protest', 'protest', 'protest',
        'strike', 'strike', 'strike', 'strike',
        'occupation',
      ];

  // ===== BUREAUCRAT =====
  static List<String> get bureaucratDeck => [
        'red_tape', 'red_tape', 'red_tape', 'red_tape', 'red_tape',
        'circular', 'circular', 'circular', 'circular',
        'infinite_loop',
      ];

  // Ottieni mazzo base per nome classe (stringa)
  static List<String> getStarterDeck(String characterClass) {
    switch (characterClass.toLowerCase()) {
      case 'corrupt politician':
        return corruptPoliticianDeck;
      case 'attack journalist':
        return attackJournalistDeck;
      case 'activist':
        return activistDeck;
      case 'bureaucrat':
        return bureaucratDeck;
      default:
        return corruptPoliticianDeck; // Default sicuro
    }
  }

  // Ottieni HP iniziale per classe
  static int getStartingHp(String characterClass) {
    switch (characterClass.toLowerCase()) {
      case 'corrupt politician':
        return 66;
      case 'attack journalist':
        return 60;
      case 'activist':
        return 64;
      case 'bureaucrat':
        return 70;
      default:
        return 66;
    }
  }
}