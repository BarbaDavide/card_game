import 'package:flutter/material.dart';
import '../../ui/theme/app_theme.dart';
import '../../services/sound_manager.dart';

/// Splash Screen - Schermata iniziale con animazione
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    // Naviga al menu principale dopo l'animazione
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        _navigateToNextScreen();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() {
    // TODO: Controlla se è il primo avvio per mostrare onboarding
    // Per ora vai direttamente al main menu
    Navigator.of(context).pushReplacementNamed('/main-menu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo/Icon
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.primary, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.4),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.deck,
                      size: 80,
                      color: AppTheme.primary,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Title
                  Text(
                    'ROGUE CARD',
                    style: AppTheme.headline1.copyWith(
                      fontSize: 40,
                      letterSpacing: 8,
                      shadows: [
                        Shadow(
                          color: AppTheme.primary.withOpacity(0.5),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Subtitle
                  Text(
                    'A Roguelike Card Game',
                    style: AppTheme.bodyMedium.copyWith(
                      letterSpacing: 3,
                      fontSize: 12,
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Loading indicator
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                    strokeWidth: 3,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Version text
                  Text(
                    'Version 1.0.0',
                    style: AppTheme.caption.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
