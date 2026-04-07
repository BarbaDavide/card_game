// lib/domain/models/card.dart

enum CardRarity { common, uncommon, rare, epic, legendary }
enum CardType { attack, skill, power }

class Card {
  final String id;
  final String name;
  final String description;
  final int manaCost;
  final CardType type;
  final CardRarity rarity;
  final int baseDamage;    // Danno base per attacchi
  final int block;         // Blocco per skill difensive
  final int drawCards;     // Carte pescate
  final bool exhaust;      // Si esaurisce dopo l'uso
  final bool upgradeable;  // Può essere migliorata
  final String politicalEffect; // Effetto satirico/politico (opzionale)

  const Card({
    required this.id,
    required this.name,
    required this.description,
    required this.manaCost,
    required this.type,
    required this.rarity,
    required this.baseDamage,
    required this.block,
    required this.drawCards,
    required this.exhaust,
    required this.upgradeable,
    this.politicalEffect = '',
  });

  // Crea una versione migliorata della carta
  Card get upgraded {
    return Card(
      id: '${id}_upgraded',
      name: 'Upgraded $name',
      description: 'Enhanced version: $description',
      manaCost: manaCost,
      type: type,
      rarity: rarity,
      baseDamage: baseDamage + (type == CardType.attack ? 3 : 0),
      block: block + (type == CardType.skill ? 3 : 0),
      drawCards: drawCards + 1,
      exhaust: exhaust,
      upgradeable: false,
      politicalEffect: politicalEffect,
    );
  }

  @override
  String toString() => 'Card($name, $manaCost⚡, ${type.name}, ${rarity.name})';
}