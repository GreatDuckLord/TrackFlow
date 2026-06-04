import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../app/app_localizations.dart';
import '../services/carrier_urls.dart';
import '../services/locale_manager.dart';
import '../services/theme_manager.dart';
import 'help_center_screen.dart';
import 'send_feedback_screen.dart';
import 'about_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String selectedLanguage = LocaleManager.currentLanguage;
  String selectedAppearance = ThemeManager.currentThemeLabel;

  @override
  void initState() {
    super.initState();
    LocaleManager.localeNotifier.addListener(_handleLocaleChanged);
    ThemeManager.themeModeNotifier.addListener(_handleThemeChanged);
  }

  @override
  void dispose() {
    LocaleManager.localeNotifier.removeListener(_handleLocaleChanged);
    ThemeManager.themeModeNotifier.removeListener(_handleThemeChanged);
    super.dispose();
  }

  void _handleLocaleChanged() {
    if (!mounted) return;
    setState(() {
      selectedLanguage = LocaleManager.currentLanguage;
    });
  }

  void _handleThemeChanged() {
    if (!mounted) return;
    setState(() {
      selectedAppearance = ThemeManager.currentThemeLabel;
    });
  }

  Future<void> _saveSelectedLanguage(String language) async {
    setState(() {
      selectedLanguage = language;
    });
    await LocaleManager.setLanguage(language);
  }

  Future<void> _saveSelectedAppearance(String label) async {
    setState(() {
      selectedAppearance = label;
    });
    await ThemeManager.setThemeMode(label);
  }

  void _showLanguageSelector() {
    final languages = ['English', 'Spanish', 'French', 'German', 'Italian', 'Arabic'];
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(AppLocalizations.of(context).selectLanguage),
        children: languages.map((language) {
          return SimpleDialogOption(
            onPressed: () {
              _saveSelectedLanguage(language);
              Navigator.of(context).pop();
            },
            child: Text(language),
          );
        }).toList(),
      ),
    );
  }

  void _showAppearanceSelector() {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Map internal keys to localized labels & icons
    final options = <Map<String, dynamic>>[
      {'key': 'System', 'label': loc.systemDefault, 'icon': Icons.settings_suggest_rounded},
      {'key': 'Light', 'label': loc.lightMode, 'icon': Icons.light_mode_rounded},
      {'key': 'Dark', 'label': loc.darkMode, 'icon': Icons.dark_mode_rounded},
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                loc.selectAppearance,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              ...options.map((opt) {
                final isSelected = opt['key'] == selectedAppearance;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: isSelected
                        ? colorScheme.primaryContainer
                        : colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        _saveSelectedAppearance(opt['key'] as String);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Row(
                          children: [
                            Icon(
                              opt['icon'] as IconData,
                              color: isSelected
                                  ? colorScheme.onPrimaryContainer
                                  : colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                opt['label'] as String,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  color: isSelected
                                      ? colorScheme.onPrimaryContainer
                                      : colorScheme.onSurface,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: colorScheme.primary,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  String _localizedAppearanceSubtitle() {
    final loc = AppLocalizations.of(context);
    switch (selectedAppearance) {
      case 'Light':
        return loc.lightMode;
      case 'Dark':
        return loc.darkMode;
      default:
        return loc.systemDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).settings,
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ).animate().fadeIn(duration: 400.ms),

            const SizedBox(height: 24),

            // Profile card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primaryContainer,
                    colorScheme.secondaryContainer,
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: colorScheme.primary,
                    child: Text(
                      'YB',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Yahya Bahmed',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'YahyaBahmed@proton.me',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit_rounded, color: colorScheme.onPrimaryContainer),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms, duration: 400.ms).slideY(
                  begin: 0.1,
                  delay: 100.ms,
                  curve: Curves.easeOutCubic,
                ),
            const SizedBox(height: 28),

            // Supported carriers
            Card(
              margin: const EdgeInsets.only(bottom: 6),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
              ),
              child: ExpansionTile(
                leading: Icon(Icons.local_shipping_outlined, color: colorScheme.onSurfaceVariant),
                title: Text(
                  AppLocalizations.of(context).supportedCarriers,
                  style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
                shape: const Border(), // Removes default border when expanded
                collapsedShape: const Border(),
                childrenPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                children: CarrierUrls.allCarriers.map((carrier) {
                  final isDark = theme.brightness == Brightness.dark;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.2)),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 32, height: 32,
                        decoration: BoxDecoration(
                          color: carrier.color.withValues(alpha: isDark ? 0.2 : 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(carrier.icon, color: carrier.color, size: 16),
                      ),
                      title: Text(carrier.name, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                      subtitle: Text(
                        AppLocalizations.of(context).autoDetectEnabled,
                        style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.outline),
                      ),
                      trailing: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 18),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 28),

            // Settings sections
            _SectionHeader(title: AppLocalizations.of(context).preferences),
            const SizedBox(height: 8),
            _SettingsTile(
              icon: Icons.language_rounded,
              title: AppLocalizations.of(context).language,
              subtitle: selectedLanguage,
              onTap: _showLanguageSelector,
            ),
            _SettingsTile(
              icon: Icons.dark_mode_outlined,
              title: AppLocalizations.of(context).appearance,
              subtitle: _localizedAppearanceSubtitle(),
              onTap: _showAppearanceSelector,
            ),

            const SizedBox(height: 20),
            _SectionHeader(title: AppLocalizations.of(context).support),
            const SizedBox(height: 8),
            _SettingsTile(
              icon: Icons.help_outline_rounded,
              title: AppLocalizations.of(context).helpCenter,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const HelpCenterScreen()),
                );
              },
            ),
            _SettingsTile(
              icon: Icons.feedback_outlined,
              title: AppLocalizations.of(context).sendFeedback,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SendFeedbackScreen()),
                );
              },
            ),
            _SettingsTile(
              icon: Icons.info_outline_rounded,
              title: AppLocalizations.of(context).about,
              subtitle: 'Beta 1.0.0',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AboutScreen()),
                );
              },
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout_rounded),
                label: Text(AppLocalizations.of(context).signOut),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.error,
                  side: BorderSide(color: colorScheme.error.withValues(alpha: 0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.primary,
          ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: colorScheme.onSurfaceVariant),
        title: Text(title, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
        subtitle: subtitle != null
            ? Text(subtitle!, style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.outline))
            : null,
        trailing: Icon(Icons.chevron_right_rounded, color: colorScheme.outlineVariant),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
