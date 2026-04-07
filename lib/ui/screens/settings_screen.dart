import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ui/theme/app_theme.dart';
import '../../services/sound_manager.dart';
import '../providers/settings_provider.dart';

/// Settings Screen - Gestione impostazioni gioco
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late double musicVolume;
  late double sfxVolume;
  late bool isMuted;
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);
    musicVolume = settings.musicVolume;
    sfxVolume = settings.sfxVolume;
    isMuted = settings.isMuted;
    selectedLanguage = settings.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AppSoundManager().playSFX(SFX.buttonClick);
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Audio Section
              _buildSectionHeader(AppLocalizations.of(context).audio),
              _buildCard(
                child: Column(
                  children: [
                    _buildVolumeSlider(
                      label: AppLocalizations.of(context).musicVolume,
                      icon: Icons.music_note,
                      value: musicVolume,
                      onChanged: (value) {
                        setState(() => musicVolume = value);
                        AppSoundManager().setMusicVolume(value);
                        ref.read(settingsProvider.notifier).updateMusicVolume(value);
                      },
                    ),
                    const Divider(height: 1),
                    _buildVolumeSlider(
                      label: AppLocalizations.of(context).sfxVolume,
                      icon: Icons.volume_up,
                      value: sfxVolume,
                      onChanged: (value) {
                        setState(() => sfxVolume = value);
                        AppSoundManager().setSfxVolume(value);
                        ref.read(settingsProvider.notifier).updateSfxVolume(value);
                      },
                    ),
                    const Divider(height: 1),
                    _buildMuteToggle(),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Language Section
              _buildSectionHeader(AppLocalizations.of(context).language),
              _buildCard(
                child: Column(
                  children: [
                    _buildLanguageTile('en', 'English'),
                    const Divider(height: 1),
                    _buildLanguageTile('it', 'Italiano'),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Game Section
              _buildSectionHeader(AppLocalizations.of(context).game),
              _buildCard(
                child: Column(
                  children: [
                    _buildInfoTile(
                      icon: Icons.save,
                      title: AppLocalizations.of(context).saveSlots,
                      subtitle: AppLocalizations.of(context).threeSaveSlots,
                    ),
                    const Divider(height: 1),
                    _buildInfoTile(
                      icon: Icons.auto_save,
                      title: AppLocalizations.of(context).autoSave,
                      subtitle: AppLocalizations.of(context).enabled,
                      trailing: const Icon(Icons.check, color: AppTheme.success),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // About Section
              _buildSectionHeader(AppLocalizations.of(context).about),
              _buildCard(
                child: Column(
                  children: [
                    _buildInfoTile(
                      icon: Icons.info_outline,
                      title: AppLocalizations.of(context).version,
                      subtitle: '1.0.0',
                    ),
                    const Divider(height: 1),
                    _buildInfoTile(
                      icon: Icons.code,
                      title: AppLocalizations.of(context).engine,
                      subtitle: 'Flutter + Flame',
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Reset Data Button
              Center(
                child: TextButton.icon(
                  icon: const Icon(Icons.delete_outline, color: AppTheme.error),
                  label: Text(
                    AppLocalizations.of(context).resetAllData,
                    style: const TextStyle(color: AppTheme.error),
                  ),
                  onPressed: () => _showResetDialog(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppTheme.textSecondary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
      ),
      child: child,
    );
  }

  Widget _buildVolumeSlider({
    required String label,
    required IconData icon,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.secondary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(label, style: AppTheme.bodyLarge),
          ),
          Expanded(
            flex: 2,
            child: Slider(
              value: value,
              min: 0,
              max: 1,
              divisions: 10,
              activeColor: AppTheme.primary,
              inactiveColor: AppTheme.surface,
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              '${(value * 100).toInt()}%',
              style: AppTheme.bodyMedium.copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMuteToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            isMuted ? Icons.volume_off : Icons.volume_up,
            color: isMuted ? AppTheme.error : AppTheme.secondary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              AppLocalizations.of(context).muteAll,
              style: AppTheme.bodyLarge,
            ),
          ),
          Switch(
            value: isMuted,
            onChanged: (value) {
              setState(() => isMuted = value);
              AppSoundManager().toggleMute();
              ref.read(settingsProvider.notifier).toggleMute();
            },
            activeColor: AppTheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(String code, String name) {
    final isSelected = selectedLanguage == code;
    return ListTile(
      leading: Icon(
        Icons.language,
        color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
      ),
      title: Text(
        name,
        style: TextStyle(
          color: isSelected ? AppTheme.textPrimary : AppTheme.textSecondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppTheme.primary)
          : null,
      onTap: () {
        AppSoundManager().playSFX(SFX.buttonClick);
        setState(() => selectedLanguage = code);
        ref.read(settingsProvider.notifier).updateLanguage(code);
      },
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.textSecondary),
      title: Text(title, style: AppTheme.bodyLarge),
      subtitle: Text(subtitle, style: AppTheme.bodySmall),
      trailing: trailing,
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).resetData),
        content: Text(AppLocalizations.of(context).resetDataConfirm),
        actions: [
          TextButton(
            onPressed: () {
              AppSoundManager().playSFX(SFX.buttonClick);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context).cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            onPressed: () {
              AppSoundManager().playSFX(SFX.buttonClick);
              // TODO: Implement reset logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).dataReset)),
              );
            },
            child: Text(AppLocalizations.of(context).reset),
          ),
        ],
      ),
    );
  }
}
