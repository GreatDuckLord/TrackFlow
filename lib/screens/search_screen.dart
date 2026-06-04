import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../app/app_localizations.dart';
import '../services/carrier_detector.dart';
import '../services/carrier_urls.dart';
import '../services/package_persistence.dart';
import '../models/tracking_entry.dart';
import 'carrier_webview_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<String> _detectedCarriers = [];
  List<TrackingEntry> _recentEntries = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _loadRecentEntries();
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() => _detectedCarriers = []);
      return;
    }
    setState(() => _detectedCarriers = CarrierDetector.detect(text));
  }

  Future<void> _loadRecentEntries() async {
    final entries = await TrackingHistory().loadEntries();
    if (mounted) setState(() => _recentEntries = entries.take(5).toList());
  }

  void _openTracking(String carrierId, String trackingNumber) async {
    final carrierInfo = CarrierUrls.getCarrier(carrierId);
    final carrierName = carrierInfo?.name ?? CarrierDetector.carrierName(carrierId);

    // Save to history
    await TrackingHistory().saveEntry(TrackingEntry(
      trackingNumber: trackingNumber.trim(),
      carrierId: carrierId,
      carrierName: carrierName,
      createdAt: DateTime.now(),
    ));

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CarrierWebViewScreen(
          carrierId: carrierId,
          carrierName: carrierName,
          trackingNumber: trackingNumber.trim(),
        ),
      ),
    );
  }

  void _showCarrierPicker(String trackingNumber) {
    final allCarriers = CarrierUrls.allCarriers;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.85,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40, height: 4,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(AppLocalizations.of(context).selectCarrier, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context).couldNotAutoDetectCarrier,
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: allCarriers.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final carrier = allCarriers[index];
                        return _CarrierTile(
                          carrier: carrier,
                          onTap: () {
                            Navigator.pop(context);
                            _openTracking(carrier.id, trackingNumber);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _controller.text.trim();
    final hasInput = query.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
        ),
        title: Text(AppLocalizations.of(context).trackPackage),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search field
            TextField(
              controller: _controller,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                if (value.trim().isEmpty) return;
                if (_detectedCarriers.length == 1) {
                  _openTracking(_detectedCarriers.first, value);
                } else if (_detectedCarriers.isEmpty) {
                  _showCarrierPicker(value);
                }
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context).enterTrackingNumberHint,
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: hasInput
                    ? IconButton(
                        onPressed: () {
                          _controller.clear();
                          setState(() => _detectedCarriers = []);
                        },
                        icon: const Icon(Icons.clear_rounded),
                      )
                    : null,
              ),
            ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1),

            const SizedBox(height: 20),

            // Auto-detected carriers
            if (hasInput && _detectedCarriers.isNotEmpty)
              _buildDetectedCarriers(context)
            else if (hasInput && _detectedCarriers.isEmpty)
              _buildNoMatch(context)
            else
              _buildRecentHistory(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetectedCarriers(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final query = _controller.text.trim();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, size: 18, color: colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                _detectedCarriers.length == 1
                    ? AppLocalizations.of(context).carrierDetected
                    : AppLocalizations.of(context).possibleCarriers,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ).animate().fadeIn(duration: 300.ms),
          const SizedBox(height: 12),

          Expanded(
            child: ListView.separated(
              itemCount: _detectedCarriers.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final carrierId = _detectedCarriers[index];
                final carrier = CarrierUrls.getCarrier(carrierId);
                if (carrier == null) return const SizedBox.shrink();

                return _DetectedCarrierCard(
                  carrier: carrier,
                  trackingNumber: query,
                  onTrack: () => _openTracking(carrierId, query),
                ).animate().fadeIn(
                      delay: Duration(milliseconds: index * 100),
                      duration: 300.ms,
                    ).slideY(begin: 0.1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoMatch(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.errorContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colorScheme.error.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              Icon(Icons.help_outline_rounded, size: 36, color: colorScheme.error),
              const SizedBox(height: 12),
              Text(
                AppLocalizations.of(context).carrierNotRecognized,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.error,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                AppLocalizations.of(context).couldNotIdentifyCarrier,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => _showCarrierPicker(_controller.text.trim()),
                icon: const Icon(Icons.list_rounded, size: 18),
                label: Text(AppLocalizations.of(context).selectCarrierManually),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 300.ms).shake(hz: 2, offset: const Offset(2, 0)),
      ],
    );
  }

  Widget _buildRecentHistory(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (_recentEntries.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          Center(
            child: Column(
              children: [
                Icon(Icons.manage_search_rounded, size: 64, color: colorScheme.outlineVariant),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context).enterATrackingNumber,
                  style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    AppLocalizations.of(context).trackingDescription,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.outline),
                  ),
                ),
              ],
            ),
          ),
        ],
      ).animate().fadeIn(delay: 200.ms, duration: 400.ms);
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context).recent, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _recentEntries.length,
              itemBuilder: (context, index) {
                final entry = _recentEntries[index];
                final carrier = CarrierUrls.getCarrier(entry.carrierId);
                return ListTile(
                  leading: Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: (carrier?.color ?? colorScheme.primary).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      carrier?.icon ?? Icons.local_shipping_rounded,
                      color: carrier?.color ?? colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  title: Text(entry.trackingNumber, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w600)),
                  subtitle: Text(entry.carrierName, style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant)),
                  dense: true,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onTap: () {
                    _controller.text = entry.trackingNumber;
                    _openTracking(entry.carrierId, entry.trackingNumber);
                  },
                );
              },
            ),
          ),
        ],
      ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
    );
  }
}

/// Card showing a detected carrier with a Track button.
class _DetectedCarrierCard extends StatelessWidget {
  final CarrierInfo carrier;
  final String trackingNumber;
  final VoidCallback onTrack;

  const _DetectedCarrierCard({
    required this.carrier,
    required this.trackingNumber,
    required this.onTrack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            carrier.color.withValues(alpha: isDark ? 0.2 : 0.08),
            carrier.color.withValues(alpha: isDark ? 0.08 : 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: carrier.color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: carrier.color.withValues(alpha: isDark ? 0.3 : 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(carrier.icon, color: carrier.color, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carrier.name,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      trackingNumber,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                        color: colorScheme.onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onTrack,
              icon: const Icon(Icons.open_in_browser_rounded, size: 18),
              label: Text(AppLocalizations.of(context).trackNow),
              style: FilledButton.styleFrom(
                backgroundColor: carrier.color,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Tile for manual carrier selection in the bottom sheet.
class _CarrierTile extends StatelessWidget {
  final CarrierInfo carrier;
  final VoidCallback onTap;

  const _CarrierTile({required this.carrier, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: carrier.color.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: carrier.color.withValues(alpha: isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(carrier.icon, color: carrier.color, size: 20),
        ),
        title: Text(carrier.name, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.arrow_forward_rounded, color: carrier.color, size: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
