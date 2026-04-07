// lib/data/card_database.dart

import '../domain/models/card.dart';
import './game_state.dart'; // Importa PoliticalClass da game_state.dart

/// Database di carte satiriche politiche italiane
class CardDatabase {
  // Singleton
  static final CardDatabase _instance = CardDatabase._internal();
  factory CardDatabase() => _instance;
  CardDatabase._internal();

  // ===== CARTE COMUNI =====
  
  // Politico Corrotto
  final Card corruzioneLeggera = Card(
    id: 'corruzione_leggera',
    name: 'Corruzione Leggera',
    description: 'Ricevi una mazzetta. Guadagna 500€.',
    manaCost: 1,
    type: CardType.attack,
    rarity: CardRarity.common,
    baseDamage: 0,
    block: 0,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  final Card scontoFiscale = Card(
    id: 'sconto_fiscale',
    name: 'Sconto Fiscale',
    description: 'Evasione fiscale legalizzata. Blocca 8 danni.',
    manaCost: 1,
    type: CardType.skill,
    rarity: CardRarity.common,
    baseDamage: 0,
    block: 8,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  // Giornalista
  final Card fakeNews = Card(
    id: 'fake_news',
    name: 'Fake News',
    description: 'Diffondi notizie false. Infligge 6 danni e indebolisce.',
    manaCost: 1,
    type: CardType.attack,
    rarity: CardRarity.common,
    baseDamage: 6,
    block: 0,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  final Card ricatto = Card(
    id: 'ricatto',
    name: 'Ricatto',
    description: 'Minaccia di rivelare segreti. Blocca 5 danni.',
    manaCost: 1,
    type: CardType.skill,
    rarity: CardRarity.common,
    baseDamage: 0,
    block: 5,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  // Attivista
  final Card manifestazione = Card(
    id: 'manifestazione',
    name: 'Manifestazione',
    description: 'Scendi in piazza. Infligge 7 danni.',
    manaCost: 1,
    type: CardType.attack,
    rarity: CardRarity.common,
    baseDamage: 7,
    block: 0,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  final Card sciopero = Card(
    id: 'sciopero',
    name: 'Sciopero',
    description: 'Blocca tutto. Blocca 10 danni.',
    manaCost: 1,
    type: CardType.skill,
    rarity: CardRarity.common,
    baseDamage: 0,
    block: 10,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  // Burocrate
  final Card cartaBurocratica = Card(
    id: 'carta_burocratica',
    name: 'Carta Burocratica',
    description: 'Pratica infinita. Infligge 5 danni.',
    manaCost: 1,
    type: CardType.attack,
    rarity: CardRarity.common,
    baseDamage: 5,
    block: 0,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  final Card rinvio = Card(
    id: 'rinvio',
    name: 'Rinvio',
    description: 'Rimanda a data da destinarsi. Blocca 6 danni.',
    manaCost: 1,
    type: CardType.skill,
    rarity: CardRarity.common,
    baseDamage: 0,
    block: 6,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  // ===== CARTE NON COMUNI =====
  
  final Card leggeAdPersonam = Card(
    id: 'legge_ad_personam',
    name: 'Legge Ad Personam',
    description: 'Cambia le regole per te. Infligge 12 danni.',
    manaCost: 2,
    type: CardType.attack,
    rarity: CardRarity.uncommon,
    baseDamage: 12,
    block: 0,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  final Card inchiesta = Card(
    id: 'inchiesta',
    name: 'Inchiesta Esplosiva',
    description: 'Scopri verità scomode. Infligge 10 danni, pesca 2 carte.',
    manaCost: 2,
    type: CardType.attack,
    rarity: CardRarity.uncommon,
    baseDamage: 10,
    block: 0,
    manaGain: 0,
    drawCards: 2,
    exhaust: false,
    upgradeable: true,
  );

  final Card occupazione = Card(
    id: 'occupazione',
    name: 'Occupazione',
    description: 'Occupazione pacifica. Infligge 8 danni, blocca 8.',
    manaCost: 2,
    type: CardType.attack,
    rarity: CardRarity.uncommon,
    baseDamage: 8,
    block: 8,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  final Card leggeQuadro = Card(
    id: 'legge_quadro',
    name: 'Legge Quadro',
    description: 'Legge complicata. Blocca 15 danni.',
    manaCost: 2,
    type: CardType.skill,
    rarity: CardRarity.uncommon,
    baseDamage: 0,
    block: 15,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: true,
  );

  // ===== CARTE RARE (dopo boss fight) =====
  
  final Card tangente = Card(
    id: 'tangente',
    name: 'Tangente',
    description: 'Mazzetta pesante. Infligge 20 danni, guadagna 2000€.',
    manaCost: 3,
    type: CardType.attack,
    rarity: CardRarity.rare,
    baseDamage: 20,
    block: 0,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: false,
  );

  final Card conflittoInteressi = Card(
    id: 'conflitto_interessi',
    name: 'Conflitto di Interessi',
    description: 'Approfitta della tua posizione. Raddoppia i danni questo turno.',
    manaCost: 2,
    type: CardType.power,
    rarity: CardRarity.rare,
    baseDamage: 0,
    block: 0,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: false,
  );

  // ===== CARTE EPICHE (dopo boss fight finale) =====
  
  final Card leggeSalvaLadri = Card(
    id: 'legge_salva_ladri',
    name: 'Legge Salva-Ladri',
    description: 'Immunità totale. Blocca TUTTO il danno, infligge 30 danni.',
    manaCost: 4,
    type: CardType.power,
    rarity: CardRarity.epic,
    baseDamage: 30,
    block: 999,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: false,
  );

  final Card colpoDiStato = Card(
    id: 'colpo_di_stato',
    name: 'Colpo di Stato',
    description: 'Prendi il potere assoluto. Vittoria immediata.',
    manaCost: 5,
    type: CardType.attack,
    rarity: CardRarity.legendary,
    baseDamage: 999,
    block: 0,
    manaGain: 0,
    drawCards: 0,
    exhaust: false,
    upgradeable: false,
  );

  // ===== METODI DI ACCESSO =====
  
  List<Card> get allCards => [
        corruzioneLeggera,
        scontoFiscale,
        fakeNews,
        ricatto,
        manifestazione,
        sciopero,
        cartaBurocratica,
        rinvio,
        leggeAdPersonam,
        inchiesta,
        occupazione,
        leggeQuadro,
        tangente,
        conflittoInteressi,
        leggeSalvaLadri,
        colpoDiStato,
      ];

  List<Card> getStartingDeck(PoliticalClass character) {
    switch (character) {
      case PoliticalClass.corruptPolitician:
        return [
          corruzioneLeggera,
          corruzioneLeggera,
          corruzioneLeggera,
          corruzioneLeggera,
          corruzioneLeggera,
          scontoFiscale,
          scontoFiscale,
          scontoFiscale,
          scontoFiscale,
          leggeAdPersonam,
        ];
      case PoliticalClass.journalist:
        return [
          fakeNews,
          fakeNews,
          fakeNews,
          fakeNews,
          fakeNews,
          ricatto,
          ricatto,
          ricatto,
          ricatto,
          ricatto,
          inchiesta,
        ];
      case PoliticalClass.activist:
        return [
          manifestazione,
          manifestazione,
          manifestazione,
          manifestazione,
          manifestazione,
          sciopero,
          sciopero,
          sciopero,
          sciopero,
          sciopero,
          occupazione,
        ];
      case PoliticalClass.bureaucrat:
        return [
          cartaBurocratica,
          cartaBurocratica,
          cartaBurocratica,
          cartaBurocratica,
          cartaBurocratica,
          rinvio,
          rinvio,
          rinvio,
          rinvio,
          rinvio,
          leggeQuadro,
        ];
    }
  }

 Card? getCardById(String id) {
  for (var card in allCards) {
    if (card.id == id) {
      return card;
    }
  }
  return null;
}

  // Carte comuni per ricompense dopo combattimenti normali
  List<Card> getCommonRewards() {
    return [
      corruzioneLeggera,
      scontoFiscale,
      fakeNews,
      ricatto,
      manifestazione,
      sciopero,
      cartaBurocratica,
      rinvio,
    ];
  }

  // Carte rare/epiche per ricompense dopo boss fight
  List<Card> getRareRewards() {
    return [
      tangente,
      conflittoInteressi,
      leggeSalvaLadri,
      colpoDiStato,
    ];
  }
}