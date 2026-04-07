// lib/data/game_state.dart

// Classi politiche satiriche italiane
enum PoliticalClass {
  corruptPolitician, // Politico Corrotto
  journalist,        // Giornalista d'Assalto
  activist,          // Attivista
  bureaucrat,        // Burocrate Inflessibile
}

class GameState {
  final PoliticalClass character;
  int currentLevel; // 0 = Camera, 1 = Senato, 2 = Governo
  int currentFloor;
  int currentInfluence; // Invece di HP - influenza politica
  int maxInfluence;
  int euros; // Invece di gold - soldi/euro
  List<String> deck; // ID carte politiche
  List<String> perks; // Invece di reliquie - privilegi/perks
  String currentNodeId;
  List<String> visitedNodeIds;
  bool isBossDefeated;
  bool isGameOver;

  GameState({
    required this.character,
    this.currentLevel = 0,
    this.currentFloor = 0,
    this.currentInfluence = 0,
    this.maxInfluence = 0,
    this.euros = 10000, // Inizia con 10.000€
    this.deck = const [],
    this.perks = const [],
    this.currentNodeId = 'node_0',
    this.visitedNodeIds = const [],
    this.isBossDefeated = false,
    this.isGameOver = false,
  });

  // Factory per creare una nuova campagna
  factory GameState.newCampaign(PoliticalClass character) {
    int influence;
    List<String> startingDeck;
    
    switch (character) {
      case PoliticalClass.corruptPolitician:
        // Politico Corrotto: alta influenza, carte corruzione
        influence = 100;
        startingDeck = [
          'corruzione_leggera', // Corruzione Leggera
          'corruzione_leggera',
          'corruzione_leggera',
          'corruzione_leggera',
          'corruzione_leggera',
          'sconto_fiscale', // Sconto Fiscale
          'sconto_fiscale',
          'sconto_fiscale',
          'sconto_fiscale',
          'legge_ad_personam', // Legge Ad Personam
        ];
        break;
        
      case PoliticalClass.journalist:
        // Giornalista: media influenza, carte fake news
        influence = 80;
        startingDeck = [
          'fake_news', // Fake News
          'fake_news',
          'fake_news',
          'fake_news',
          'fake_news',
          'ricatto', // Ricatto
          'ricatto',
          'ricatto',
          'ricatto',
          'ricatto',
          'inchiesta', // Inchiesta Esplosiva
        ];
        break;
        
      case PoliticalClass.activist:
        // Attivista: bassa influenza, carte protesta
        influence = 70;
        startingDeck = [
          'manifestazione', // Manifestazione
          'manifestazione',
          'manifestazione',
          'manifestazione',
          'manifestazione',
          'sciopero', // Sciopero
          'sciopero',
          'sciopero',
          'sciopero',
          'sciopero',
          'occupazione', // Occupazione
        ];
        break;
        
      case PoliticalClass.bureaucrat:
        // Burocrate: influenza media, carte burocratiche
        influence = 90;
        startingDeck = [
          'carta_burocratica', // Carta Burocratica
          'carta_burocratica',
          'carta_burocratica',
          'carta_burocratica',
          'carta_burocratica',
          'rinvio', // Rinvio a Data da Destinarsi
          'rinvio',
          'rinvio',
          'rinvio',
          'rinvio',
          'legge_quadro', // Legge Quadro
        ];
        break;
    }
    
    return GameState(
      character: character,
      currentInfluence: influence,
      maxInfluence: influence,
      deck: startingDeck,
      currentLevel: 0,
      currentFloor: 0,
      currentNodeId: 'node_0',
      visitedNodeIds: [],
      isBossDefeated: false,
      isGameOver: false,
    );
  }

  // Metodi di aggiornamento (immutable)
  GameState copyWith({
    int? currentLevel,
    int? currentFloor,
    int? currentInfluence,
    int? maxInfluence,
    int? euros,
    List<String>? deck,
    List<String>? perks,
    String? currentNodeId,
    List<String>? visitedNodeIds,
    bool? isBossDefeated,
    bool? isGameOver,
  }) {
    return GameState(
      character: character,
      currentLevel: currentLevel ?? this.currentLevel,
      currentFloor: currentFloor ?? this.currentFloor,
      currentInfluence: currentInfluence ?? this.currentInfluence,
      maxInfluence: maxInfluence ?? this.maxInfluence,
      euros: euros ?? this.euros,
      deck: deck ?? this.deck,
      perks: perks ?? this.perks,
      currentNodeId: currentNodeId ?? this.currentNodeId,
      visitedNodeIds: visitedNodeIds ?? this.visitedNodeIds,
      isBossDefeated: isBossDefeated ?? this.isBossDefeated,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }

  // Verifica se il politico è "finito" (senza influenza)
  bool get isFinished => currentInfluence <= 0;

  // Verifica se ha completato la carriera politica
  bool get isCampaignComplete => currentLevel >= 2 && isBossDefeated;

  @override
  String toString() {
    return 'GameState(character: $character, level: $currentLevel, floor: $currentFloor, influence: $currentInfluence/$maxInfluence, €: $euros)';
  }
}