import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../app/app_localizations.dart';

class SendFeedbackScreen extends StatefulWidget {
  const SendFeedbackScreen({super.key});

  @override
  State<SendFeedbackScreen> createState() => _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends State<SendFeedbackScreen> {
  final TextEditingController _messageController = TextEditingController();
  String _selectedCategory = 'Bug Report';
  int _rating = 0;
  bool _submitted = false;

  static const List<Map<String, dynamic>> _categories = [
    {'label': 'Bug Report', 'icon': Icons.bug_report_rounded},
    {'label': 'Feature Request', 'icon': Icons.lightbulb_outline_rounded},
    {'label': 'General', 'icon': Icons.chat_bubble_outline_rounded},
    {'label': 'Other', 'icon': Icons.more_horiz_rounded},
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() => _submitted = true);
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
              loc.sendFeedback,
              style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),

          SliverToBoxAdapter(
            child: _submitted ? _buildSuccess(theme, colorScheme, loc) : _buildForm(theme, colorScheme, loc),
          ),
        ],
      ),
    );
  }

  // ---------- Success state ----------
  Widget _buildSuccess(ThemeData theme, ColorScheme colorScheme, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_rounded, size: 48, color: colorScheme.primary),
          ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
          const SizedBox(height: 24),
          Text(
            loc.feedbackThankYou,
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
          const SizedBox(height: 8),
          Text(
            loc.feedbackThankYouDesc,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
          ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: Text(loc.feedbackBackToSettings),
          ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
        ],
      ),
    );
  }

  // ---------- Form ----------
  Widget _buildForm(ThemeData theme, ColorScheme colorScheme, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          Text(
            loc.feedbackDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ).animate().fadeIn(duration: 300.ms),

          const SizedBox(height: 24),

          // ---------- Category chips ----------
          Text(
            loc.feedbackCategory,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories.map((cat) {
              final isSelected = _selectedCategory == cat['label'];
              return ChoiceChip(
                selected: isSelected,
                avatar: Icon(
                  cat['icon'] as IconData,
                  size: 18,
                  color: isSelected ? colorScheme.onSecondaryContainer : colorScheme.onSurfaceVariant,
                ),
                label: Text(cat['label'] as String),
                onSelected: (_) => setState(() => _selectedCategory = cat['label'] as String),
              );
            }).toList(),
          ).animate().fadeIn(delay: 100.ms, duration: 350.ms),

          const SizedBox(height: 28),

          // ---------- Rating ----------
          Text(
            loc.feedbackRateExperience,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) {
              final starIndex = index + 1;
              return GestureDetector(
                onTap: () => setState(() => _rating = starIndex),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    starIndex <= _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: starIndex <= _rating ? Colors.amber : colorScheme.outlineVariant,
                    size: 36,
                  ),
                ),
              );
            }),
          ).animate().fadeIn(delay: 150.ms, duration: 350.ms),

          const SizedBox(height: 28),

          // ---------- Message ----------
          Text(
            loc.feedbackMessage,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _messageController,
            maxLines: 6,
            decoration: InputDecoration(
              hintText: loc.feedbackMessageHint,
              alignLabelWithHint: true,
            ),
            onChanged: (_) => setState(() {}),
          ).animate().fadeIn(delay: 200.ms, duration: 350.ms),

          const SizedBox(height: 32),

          // ---------- Submit ----------
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _messageController.text.trim().isNotEmpty ? _handleSubmit : null,
              icon: const Icon(Icons.send_rounded, size: 18),
              label: Text(loc.feedbackSubmit),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ).animate().fadeIn(delay: 250.ms, duration: 350.ms),
        ],
      ),
    );
  }
}
