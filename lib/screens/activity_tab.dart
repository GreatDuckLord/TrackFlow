import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../app/app_localizations.dart';
import '../models/tracking_entry.dart';
import '../services/package_persistence.dart';
import '../services/carrier_urls.dart';
import 'carrier_webview_screen.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({super.key});

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  List<TrackingEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await TrackingHistory().loadEntries();
    if (mounted) setState(() => _entries = entries);
  }

  Future<void> _clearAllHistory() async {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(loc.clearAll),
          content: Text(loc.clearAllConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(loc.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.error,
              ),
              child: Text(loc.clear),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await TrackingHistory().clearAll();
      if (mounted) {
        setState(() {
          _entries = [];
        });
      }
    }
  }

  Future<void> _confirmDeleteEntry(TrackingEntry entry) async {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(loc.deleteEntry),
          content: Text(loc.deleteEntryConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(loc.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.error,
              ),
              child: Text(loc.delete),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await TrackingHistory().removeEntry(entry.id);
      _loadEntries();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Group by date
    final grouped = <String, List<TrackingEntry>>{};
    final dateFormat = DateFormat('EEEE, MMM d');
    for (final entry in _entries) {
      final key = dateFormat.format(entry.createdAt);
      grouped.putIfAbsent(key, () => []).add(entry);
    }

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context).activity,
                    style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  if (_entries.isNotEmpty)
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == 'clear_all') {
                          _clearAllHistory();
                        }
                      },
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'clear_all',
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline_rounded, color: colorScheme.error),
                              const SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context).clearAll,
                                style: TextStyle(color: colorScheme.error),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ).animate().fadeIn(duration: 400.ms),
            ),
          ),
          if (_entries.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(48),
                child: Column(
                  children: [
                    Icon(Icons.timeline_rounded, size: 64, color: colorScheme.outlineVariant),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).noActivityYet,
                      style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context).historyWillAppearHere,
                      style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
                    ),
                  ],
                ),
              ),
            ),
          ...grouped.entries.map((group) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        group.key,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ...group.value.asMap().entries.map((e) {
                      final entry = e.value;
                      final idx = e.key;
                      final carrier = CarrierUrls.getCarrier(entry.carrierId);
                      final carrierColor = carrier?.color ?? colorScheme.primary;
                      final timeFormat = DateFormat('h:mm a');

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.2)),
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CarrierWebViewScreen(
                                    carrierId: entry.carrierId,
                                    carrierName: entry.carrierName,
                                    trackingNumber: entry.trackingNumber,
                                  ),
                                ),
                              );
                            },
                            onLongPress: () => _confirmDeleteEntry(entry),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            leading: Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(
                                color: carrierColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                carrier?.icon ?? Icons.local_shipping_rounded,
                                color: carrierColor,
                                size: 20,
                              ),
                            ),
                            title: Text(
                              AppLocalizations.of(context).trackedVia(entry.carrierName),
                              style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              entry.trackingNumber,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontFamily: 'monospace',
                              ),
                            ),
                            trailing: Text(
                              timeFormat.format(entry.createdAt),
                              style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.outline),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        ),
                      ).animate().fadeIn(
                            delay: Duration(milliseconds: idx * 60),
                            duration: 300.ms,
                          );
                    }),
                  ],
                ),
              ),
            );
          }),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}
