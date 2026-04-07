// lib/components/merchant_offer_component.dart

import 'package:flutter/material.dart';

class MerchantOfferComponent extends StatelessWidget {
  final String type; // 'card', 'relic', 'remove', 'upgrade'
  final String name;
  final String description;
  final int price;
  final VoidCallback onBuy;
  final bool isPurchased;

  const MerchantOfferComponent({
    Key? key,
    required this.type,
    required this.name,
    required this.description,
    required this.price,
    required this.onBuy,
    this.isPurchased = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = _getTypeColor();
    final icon = _getTypeIcon();

    return GestureDetector(
      onTap: isPurchased ? null : onBuy,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isPurchased 
              ? Colors.grey[800]!.withOpacity(0.5) 
              : const Color(0xFF2A2A3A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isPurchased ? Colors.grey : color,
            width: 2,
          ),
        ),
        child: isPurchased
            ? _buildPurchasedState()
            : _buildAvailableState(context, color, icon),
      ),
    );
  }

  Widget _buildAvailableState(BuildContext context, Color color, IconData icon) {
    return Row(
      children: [
        // Icona tipo offerta
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: color),
        ),
        const SizedBox(width: 12),
        
        // Contenuto offerta
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome + prezzo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700), // Oro
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$price',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              
              // Descrizione
              Text(
                description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPurchasedState() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.check_circle, color: Colors.green, size: 24),
        SizedBox(width: 8),
        Text(
          'PURCHASED',
          style: TextStyle(
            color: Colors.green,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getTypeColor() {
    switch (type) {
      case 'card':
        return Colors.blue;
      case 'relic':
        return Colors.orange;
      case 'remove':
        return Colors.red;
      case 'upgrade':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon() {
    switch (type) {
      case 'card':
        return Icons.credit_card;
      case 'relic':
        return Icons.star;
      case 'remove':
        return Icons.delete;
      case 'upgrade':
        return Icons.upgrade;
      default:
        return Icons.help;
    }
  }
}