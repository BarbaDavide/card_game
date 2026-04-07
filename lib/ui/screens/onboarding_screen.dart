import 'package:flutter/material.dart';
import '../../ui/theme/app_theme.dart';
import '../../services/sound_manager.dart';

/// Onboarding Screen - Tutorial iniziale per nuovi giocatori
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.deck,
      title: 'Benvenuto in Rogue Card',
      description: 'Un gioco di carte roguelike dove ogni scelta conta. Costruisci il tuo mazzo e affronta nemici sempre più potenti.',
      color: AppTheme.primary,
    ),
    OnboardingPage(
      icon: Icons.swords,
      title: 'Combatti con Strategia',
      description: 'Ogni carta ha un costo in energia. Pianifica le tue mosse, blocca gli attacchi nemici e sfrutta le combo per vincere.',
      color: AppTheme.accent,
    ),
    OnboardingPage(
      icon: Icons.map,
      title: 'Esplora la Mappa',
      description: 'Scegli il tuo percorso attraverso nodi di battaglia, eventi misteriosi, mercanti e boss finali.',
      color: AppTheme.secondary,
    ),
    OnboardingPage(
      icon: Icons.card_giftcard,
      title: 'Colleziona Carte',
      description: 'Sconfiggi i nemici per ottenere nuove carte. Migliora il tuo mazzo e scopri strategie sempre diverse.',
      color: AppTheme.success,
    ),
    OnboardingPage(
      icon: Icons.save,
      title: 'Salvataggio Automatico',
      description: 'Il gioco si salva automaticamente. Puoi avere fino a 3 slot di salvataggio per le tue run.',
      color: AppTheme.warning,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    AppSoundManager().playSFX(SFX.buttonClick);
                    _completeOnboarding();
                  },
                  child: Text(
                    'Salta',
                    style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
                  ),
                ),
              ),
              
              // Page content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index]);
                  },
                ),
              ),
              
              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildIndicator(index),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Navigation button
              Padding(
                padding: const EdgeInsets.only(bottom: 32, left: 32, right: 32),
                child: ElevatedButton(
                  onPressed: () {
                    AppSoundManager().playSFX(SFX.buttonClick);
                    if (_currentPage == _pages.length - 1) {
                      _completeOnboarding();
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1 
                      ? 'Inizia a Giocare' 
                      : 'Continua',
                    style: AppTheme.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: page.color, width: 3),
            ),
            child: Icon(
              page.icon,
              size: 60,
              color: page.color,
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Title
          Text(
            page.title,
            style: AppTheme.headline2.copyWith(color: page.color),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            page.description,
            style: AppTheme.bodyLarge.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    final isActive = index == _currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primary : AppTheme.textDisabled,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _completeOnboarding() {
    Navigator.of(context).pushReplacementNamed('/main-menu');
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
