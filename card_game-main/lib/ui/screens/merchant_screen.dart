// lib/ui/screen/merchant_screen.dart

import 'package:flutter/material.dart';
import 'dart:math';

class MerchantScreen extends StatefulWidget {
  final String merchantType; // 'wall_street', 'oligarch', 'eu_lobby', 'black_market'
  final int playerEuros;
  final List<String> deck;
  final List<String> perks;

  const MerchantScreen({
    Key? key,
    required this.merchantType,
    required this.playerEuros,
    required this.deck,
    required this.perks,
  }) : super(key: key);

  @override
  State<MerchantScreen> createState() => _MerchantScreenState();
}

class _MerchantScreenState extends State<MerchantScreen> {
  int _euros = 0;
  List<String> _deck = [];
  List<String> _perks = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _euros = widget.playerEuros;
    _deck = List.from(widget.deck);
    _perks = List.from(widget.perks);
  }

  String get _merchantName {
    switch (widget.merchantType) {
      case 'wall_street': return 'Wall Street Banker';
      case 'oligarch': return 'Russian Oligarch';
      case 'eu_lobby': return 'EU Lobbyist';
      case 'black_market': return 'Shadow Broker';
      default: return 'Political Fixer';
    }
  }

  String get _merchantDescription {
    switch (widget.merchantType) {
      case 'wall_street': return 'Buys and sells political influence with cold calculation. "Greed is good."';
      case 'oligarch': return 'Trades in oil, arms, and political favors behind closed doors. "Resources are for friends."';
      case 'eu_lobby': return 'Navigates complex regulations to bend rules in your favor. "Compliance is flexible."';
      case 'black_market': return 'Sells forbidden knowledge and untraceable assets. "Plausible deniability guaranteed."';
      default: return 'Specializes in backroom deals and political favors. "Everyone has a price."';
    }
  }

  Color get _merchantColor {
    switch (widget.merchantType) {
      case 'wall_street': return Colors.amber;
      case 'oligarch': return Colors.red;
      case 'eu_lobby': return Colors.yellow;
      case 'black_market': return Colors.purple;
      default: return Colors.blue;
    }
  }

  IconData get _merchantIcon {
    switch (widget.merchantType) {
      case 'wall_street': return Icons.monetization_on;
      case 'oligarch': return Icons.account_balance;
      case 'eu_lobby': return Icons.gavel;
      case 'black_market': return Icons.lock;
      default: return Icons.business;
    }
  }

  List<MerchantOption> get _availableOptions {
    final options = <MerchantOption>[];
    
    options.add(
      MerchantOption(
        id: 'heal',
        name: 'Town Hall Meeting',
        description: 'Recover 20 political influence with your constituents',
        price: 50,
        icon: Icons.favorite,
        color: Colors.pink,
      ),
    );
    
    switch (widget.merchantType) {
      case 'wall_street':
        options.add(
          MerchantOption(
            id: 'stock_gamble',
            name: 'Stock Market Gamble',
            description: 'Risk 100€: 50% chance to double it, 50% to lose everything',
            price: 100,
            icon: Icons.trending_up,
            color: Colors.amber,
          ),
        );
        break;
      case 'oligarch':
        options.add(
          MerchantOption(
            id: 'arms_deal',
            name: 'Arms Deal',
            description: 'Pay 120€ for a "Dark Money" card (powerful one-time effect)',
            price: 120,
            icon: Icons.gavel,
            color: Colors.red,
          ),
        );
        break;
      case 'eu_lobby':
        options.add(
          MerchantOption(
            id: 'regulatory_capture',
            name: 'Regulatory Capture',
            description: 'Pay 180€ to gain immunity to next 2 debuffs',
            price: 180,
            icon: Icons.shield,
            color: Colors.yellow,
          ),
        );
        break;
      case 'black_market':
        options.add(
          MerchantOption(
            id: 'forbidden_knowledge',
            name: 'Forbidden Knowledge',
            description: 'Pay 250€ to reveal next 3 enemies on the map',
            price: 250,
            icon: Icons.visibility,
            color: Colors.purple,
          ),
        );
        break;
    }
    
    return options;
  }

  void _purchaseOption(MerchantOption option) {
    if (_euros < option.price) {
      _showMessage('Insufficient funds! Need ${option.price}€', Colors.red);
      return;
    }
    
    setState(() {
      _euros -= option.price;
    });
    
    switch (option.id) {
      case 'heal':
        _showMessage('Recovered 20 political influence!', Colors.green);
        break;
      case 'stock_gamble':
        _executeStockGamble();
        break;
      case 'arms_deal':
        _showMessage('"Dark Money" card added to deck!', Colors.amber);
        break;
      case 'regulatory_capture':
        _showMessage('Gained immunity to next 2 debuffs!', Colors.yellow);
        break;
      case 'forbidden_knowledge':
        _showMessage('Revealed next 3 enemies on the map!', Colors.purple);
        break;
    }
  }

  void _executeStockGamble() {
    final win = _random.nextBool();
    setState(() {
      if (win) {
        _euros += 200;
        _showMessage('STOCK GAMBLE WON! +200€', Colors.green);
      } else {
        _showMessage('STOCK GAMBLE LOST! -100€', Colors.red);
      }
    });
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _leaveMerchant() {
    Navigator.pop(context, {
      'euros': _euros,
      'deck': _deck,
      'perks': _perks,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A15),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121225),
        title: Row(
          children: [
            Icon(_merchantIcon, color: _merchantColor, size: 28),
            const SizedBox(width: 12),
            Text(
              _merchantName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: _leaveMerchant,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.amber, width: 1.5),
            ),
            child: Row(
              children: [
                const Icon(Icons.attach_money, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '$_euros€',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildMerchantHeader(),
          _buildMerchantDescription(),
          Expanded(child: _buildOptionsGrid()),
          _buildLeaveButton(),
        ],
      ),
    );
  }

  Widget _buildMerchantHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _merchantColor.withOpacity(0.15),
            _merchantColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: _merchantColor.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: _merchantColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: _merchantColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              _merchantIcon,
              size: 40,
              color: _merchantColor,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _merchantName.toUpperCase(),
            style: TextStyle(
              color: _merchantColor,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.8,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMerchantDescription() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF151525),
      child: Text(
        _merchantDescription,
        style: TextStyle(
          color: Colors.white70,
          fontSize: 15,
          height: 1.5,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildOptionsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: _availableOptions.length,
      itemBuilder: (context, index) {
        final option = _availableOptions[index];
        final isAffordable = _euros >= option.price;
        final isDisabled = !isAffordable;
        
        return GestureDetector(
          onTap: isDisabled ? null : () => _purchaseOption(option),
          child: Container(
            decoration: BoxDecoration(
              color: isDisabled ? const Color(0xFF1A1A25) : const Color(0xFF1A1A2A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDisabled ? Colors.grey : option.color.withOpacity(0.7),
                width: isDisabled ? 1 : 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: option.color.withOpacity(isDisabled ? 0.08 : 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    option.icon,
                    size: 32,
                    color: isDisabled ? Colors.grey : option.color,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  option.name,
                  style: TextStyle(
                    color: isDisabled ? Colors.grey : option.color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      option.description,
                      style: TextStyle(
                        color: isDisabled ? Colors.grey.withOpacity(0.6) : Colors.white70,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isAffordable
                        ? option.color.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.attach_money, size: 14, color: Colors.amber),
                      const SizedBox(width: 2),
                      Text(
                        '${option.price}€',
                        style: TextStyle(
                          color: isAffordable ? Colors.amber : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeaveButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFF121225),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _leaveMerchant,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text(
            'LEAVE MERCHANT',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ),
    );
  }
}

class MerchantOption {
  final String id;
  final String name;
  final String description;
  final int price;
  final IconData icon;
  final Color color;

  const MerchantOption({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.color,
  });
}