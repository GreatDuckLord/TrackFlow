import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../app/app_localizations.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // FAQ data – kept as plain maps so they're easy to localise later.
  static const List<Map<String, String>> _faqItems = [
    {
      'q': 'How do I track a package?',
      'a':
          'Tap the scan button on the home screen and enter your tracking number. '
              'The carrier will be auto-detected and its tracking page will open directly inside the app.',
    },
    {
      'q': 'Which carriers are supported?',
      'a':
          'TrackFlow supports all major carriers including DHL, FedEx, UPS, USPS, and many more. '
              'Check the Supported Carriers section in Settings for the full list.',
    },
    {
      'q': 'Can I track multiple packages?',
      'a':
          'Yes! Every package you track is saved to your history so you can monitor all of them from the Packages tab.',
    },
    {
      'q': 'How do I change the app language?',
      'a':
          'Go to Settings → Language and select your preferred language. The change takes effect immediately.',
    },
    {
      'q': 'How do I switch between dark and light mode?',
      'a':
          'Go to Settings → Appearance and choose System, Light, or Dark. Your preference is saved automatically.',
    },
    {
      'q': 'Is my data stored securely?',
      'a':
          'All data stays on your device. TrackFlow does not upload your tracking numbers or personal information to any server.',
    },
  ];

  List<Map<String, String>> get _filteredFaq {
    if (_searchQuery.isEmpty) return _faqItems;
    final q = _searchQuery.toLowerCase();
    return _faqItems
        .where((item) =>
            item['q']!.toLowerCase().contains(q) ||
            item['a']!.toLowerCase().contains(q))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final loc = AppLocalizations.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ---------- App Bar ----------
          SliverAppBar.large(
            title: Text(
              loc.helpCenter,
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------- Search ----------
                  TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _searchQuery = v),
                    decoration: InputDecoration(
                      hintText: loc.helpSearchHint,
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                    ),
                  ).animate().fadeIn(duration: 300.ms),

                  const SizedBox(height: 28),

                  // ---------- Quick categories ----------
                  Text(
                    loc.helpCategories,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _CategoryCard(
                        icon: Icons.local_shipping_rounded,
                        label: loc.helpTrackingIssues,
                        color: colorScheme.tertiary,
                        colorBg: colorScheme.tertiaryContainer,
                      ),
                      const SizedBox(width: 12),
                      _CategoryCard(
                        icon: Icons.settings_rounded,
                        label: loc.helpGeneralSettings,
                        color: colorScheme.secondary,
                        colorBg: colorScheme.secondaryContainer,
                      ),
                      const SizedBox(width: 12),
                      _CategoryCard(
                        icon: Icons.account_circle_rounded,
                        label: loc.helpAccount,
                        color: colorScheme.primary,
                        colorBg: colorScheme.primaryContainer,
                      ),
                    ],
                  ).animate().fadeIn(delay: 100.ms, duration: 350.ms),

                  const SizedBox(height: 28),

                  // ---------- FAQ header ----------
                  Text(
                    loc.helpFaq,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // ---------- FAQ list ----------
          if (_filteredFaq.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Center(
                  child: Text(
                    loc.helpNoResults,
                    style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _filteredFaq[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ExpansionTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                        leading: Icon(Icons.help_outline_rounded, color: colorScheme.primary, size: 22),
                        title: Text(
                          item['q']!,
                          style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        children: [
                          Text(
                            item['a']!,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(
                          delay: Duration(milliseconds: 50 * index),
                          duration: 300.ms,
                        ),
                  );
                },
                childCount: _filteredFaq.length,
              ),
            ),

          // ---------- Contact support card ----------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 48),
              child: Container(
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
                child: Column(
                  children: [
                    Icon(Icons.support_agent_rounded,
                        size: 40, color: colorScheme.onPrimaryContainer),
                    const SizedBox(height: 12),
                    Text(
                      loc.helpStillNeedHelp,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      loc.helpContactDesc,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.email_outlined, size: 18),
                      label: Text(loc.helpContactSupport),
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Small category card widget ----------

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color colorBg;

  const _CategoryCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.colorBg,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: colorBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
