import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../app/app_localizations.dart';
import '../models/tracking_entry.dart';
import '../services/package_persistence.dart';
import '../services/carrier_urls.dart';
import 'carrier_webview_screen.dart';

class TrackingTab extends StatefulWidget {
  const TrackingTab({super.key});

  @override
  State<TrackingTab> createState() => _TrackingTabState();
}

class _TrackingTabState extends State<TrackingTab> {
  List<TrackingEntry> _entries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await TrackingHistory().loadEntries();
    if (mounted) {
      setState(() {
        _entries = entries;
        _isLoading = false;
      });
    }
  }

  void _openTracking(TrackingEntry entry) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CarrierWebViewScreen(
          carrierId: entry.carrierId,
          carrierName: entry.carrierName,
          trackingNumber: entry.trackingNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: _loadEntries,
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).packages,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: colorScheme.primary,
                      ),
                    ).animate().fadeIn(duration: 400.ms).slideX(
                          begin: -0.1,
                          curve: Curves.easeOutCubic,
                        ),
                    const SizedBox(height: 4),
                    Text(
                      '${_entries.length} ${AppLocalizations.of(context).trackedShipments.toLowerCase()}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ).animate().fadeIn(delay: 100.ms, duration: 400.ms),
                    const SizedBox(height: 24),
                    _buildSummaryRow(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Entries list
            if (_entries.isEmpty && !_isLoading)
              SliverToBoxAdapter(child: _buildEmptyState(context))
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                sliver: SliverList.separated(
                  itemCount: _entries.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final entry = _entries[index];
                    return Dismissible(
                      key: Key(entry.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: colorScheme.errorContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.delete_outline_rounded, color: colorScheme.error),
                      ),
                      onDismissed: (_) async {
                        await TrackingHistory().removeEntry(entry.id);
                        setState(() => _entries.remove(entry));
                      },
                      child: _TrackingEntryCard(
                        entry: entry,
                        onTap: () => _openTracking(entry),
                      ),
                    ).animate().fadeIn(
                          delay: Duration(milliseconds: 80 * index),
                        ).slideY(begin: 0.1);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Count carriers
    final carrierCounts = <String, int>{};
    for (final e in _entries) {
      carrierCounts[e.carrierId] = (carrierCounts[e.carrierId] ?? 0) + 1;
    }
    final topCarriers = carrierCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            icon: Icons.numbers_rounded,
            label: AppLocalizations.of(context).total,
            count: _entries.length.toString(),
            color: colorScheme.primary,
            bgColor: colorScheme.primaryContainer,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            icon: Icons.local_shipping_rounded,
            label: AppLocalizations.of(context).carriers,
            count: carrierCounts.length.toString(),
            color: const Color(0xFFF59E0B),
            bgColor: const Color(0xFFFEF3C7),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryCard(
            icon: Icons.star_rounded,
            label: AppLocalizations.of(context).top,
            count: topCarriers.isNotEmpty
                ? (CarrierUrls.getCarrier(topCarriers.first.key)?.name ?? topCarriers.first.key)
                : '—',
            color: const Color(0xFF10B981),
            bgColor: const Color(0xFFD1FAE5),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.15);
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Icon(Icons.inventory_2_outlined, size: 72, color: theme.colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).noPackagesTrackedYet,
            style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).tapScanToStart,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }
}

class _TrackingEntryCard extends StatelessWidget {
  final TrackingEntry entry;
  final VoidCallback onTap;

  const _TrackingEntryCard({required this.entry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final carrier = CarrierUrls.getCarrier(entry.carrierId);
    final carrierColor = carrier?.color ?? colorScheme.primary;
    final isDark = theme.brightness == Brightness.dark;
    final dateFormat = DateFormat('MMM d, yyyy');

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.3)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              // Carrier icon
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: carrierColor.withValues(alpha: isDark ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  carrier?.icon ?? Icons.local_shipping_rounded,
                  color: carrierColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.carrierName,
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      entry.trackingNumber,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontFamily: 'monospace',
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormat.format(entry.createdAt),
                      style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.outline),
                    ),
                  ],
                ),
              ),
              Icon(Icons.open_in_new_rounded, color: carrierColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String count;
  final Color color;
  final Color bgColor;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? bgColor.withValues(alpha: 0.15) : bgColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 10),
          Text(
            count,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800, color: color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isDark ? color.withValues(alpha: 0.8) : color.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
