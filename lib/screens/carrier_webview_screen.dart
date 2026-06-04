import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import '../app/app_localizations.dart';
import '../services/carrier_urls.dart';

/// Full-screen WebView that loads a carrier's tracking page
/// with the tracking number pre-filled via URL parameters.
/// Also injects JavaScript to auto-fill form fields as a fallback.
class CarrierWebViewScreen extends StatefulWidget {
  final String carrierId;
  final String carrierName;
  final String trackingNumber;

  const CarrierWebViewScreen({
    super.key,
    required this.carrierId,
    required this.carrierName,
    required this.trackingNumber,
  });

  @override
  State<CarrierWebViewScreen> createState() => _CarrierWebViewScreenState();
}

class _CarrierWebViewScreenState extends State<CarrierWebViewScreen> {
  WebViewController? _controller;
  int _loadingProgress = 0;
  bool _isLoading = true;
  late final bool _isSupported;
  late final String _url;

  @override
  void initState() {
    super.initState();
    _url = CarrierUrls.getTrackingUrl(widget.carrierId, widget.trackingNumber);
    final autoFillJs = CarrierUrls.getAutoFillScript(widget.trackingNumber);

    // Safely check if platform supports webview_flutter natively
    _isSupported = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

    if (_isSupported) {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {
            if (mounted) setState(() => _loadingProgress = progress);
          },
          onPageStarted: (_) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
            // Auto-fill tracking input as fallback
            _controller?.runJavaScript(autoFillJs);
          },
        ),
      )
      ..loadRequest(Uri.parse(_url));
    } else {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final carrierInfo = CarrierUrls.getCarrier(widget.carrierId);
    final carrierColor = carrierInfo?.color ?? colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: carrierColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                carrierInfo?.icon ?? Icons.local_shipping_rounded,
                color: carrierColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.carrierName,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    widget.trackingNumber,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontFamily: 'monospace',
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          if (_isSupported)
            IconButton(
              onPressed: () => _controller?.reload(),
              icon: const Icon(Icons.refresh_rounded),
              tooltip: 'Reload',
            ),
          const SizedBox(width: 4),
        ],
        bottom: _isLoading
            ? PreferredSize(
                preferredSize: const Size.fromHeight(3),
                child: LinearProgressIndicator(
                  value: _loadingProgress / 100,
                  minHeight: 3,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation(carrierColor),
                ),
              )
            : null,
      ),
      body: _isSupported && _controller != null
          ? WebViewWidget(controller: _controller!)
              .animate()
              .fadeIn(duration: 400.ms)
          : _buildFallbackUI(context, carrierColor),
    );
  }

  Widget _buildFallbackUI(BuildContext context, Color carrierColor) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: carrierColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.open_in_browser_rounded, size: 40, color: carrierColor),
            ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context).inAppBrowserNotSupported,
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context).desktopBrowserUnsupported,
              style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context).trackingLink,
                    style: theme.textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _url,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton.filledTonal(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _url));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context).linkCopied)),
                          );
                        },
                        icon: const Icon(Icons.copy_rounded, size: 18),
                        tooltip: AppLocalizations.of(context).copyLink,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
