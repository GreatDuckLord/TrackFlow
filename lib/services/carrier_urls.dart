import 'package:flutter/material.dart';

/// Contains display info and tracking URL builder for each supported carrier.
class CarrierInfo {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final String Function(String trackingNumber) buildTrackingUrl;

  const CarrierInfo({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.buildTrackingUrl,
  });
}

/// Maps carrier IDs to their tracking page URLs and display metadata.
class CarrierUrls {
  static final Map<String, CarrierInfo> _carriers = {
    'fedex': CarrierInfo(
      id: 'fedex',
      name: 'FedEx',
      icon: Icons.flight_rounded,
      color: const Color(0xFF4D148C),
      buildTrackingUrl: (tn) => 'https://www.fedex.com/fedextrack/?trknbr=$tn',
    ),
    'ups': CarrierInfo(
      id: 'ups',
      name: 'UPS',
      icon: Icons.local_shipping_rounded,
      color: const Color(0xFF351C15),
      buildTrackingUrl: (tn) => 'https://www.ups.com/track?tracknum=$tn',
    ),
    'dhl': CarrierInfo(
      id: 'dhl',
      name: 'DHL',
      icon: Icons.flight_takeoff_rounded,
      color: const Color(0xFFD40511),
      buildTrackingUrl: (tn) =>
          'https://www.dhl.com/en/express/tracking.html?AWB=$tn&brand=DHL',
    ),
    'usps': CarrierInfo(
      id: 'usps',
      name: 'USPS',
      icon: Icons.mail_rounded,
      color: const Color(0xFF004B87),
      buildTrackingUrl: (tn) =>
          'https://tools.usps.com/go/TrackConfirmAction?tLabels=$tn',
    ),
    'aramex': CarrierInfo(
      id: 'aramex',
      name: 'Aramex',
      icon: Icons.public_rounded,
      color: const Color(0xFFE31E24),
      buildTrackingUrl: (tn) =>
          'https://www.aramex.com/en/track/results?ShipmentNumber=$tn',
    ),
    'amazon': CarrierInfo(
      id: 'amazon',
      name: 'Amazon Logistics',
      icon: Icons.shopping_bag_rounded,
      color: const Color(0xFFFF9900),
      buildTrackingUrl: (tn) => 'https://track.amazon.com/tracking/$tn',
    ),
    'laposte': CarrierInfo(
      id: 'laposte',
      name: 'La Poste / Colissimo',
      icon: Icons.markunread_mailbox_rounded,
      color: const Color(0xFFFFCC00),
      buildTrackingUrl: (tn) =>
          'https://www.laposte.fr/outils/suivre-vos-envois?code=$tn',
    ),
    'royalmail': CarrierInfo(
      id: 'royalmail',
      name: 'Royal Mail',
      icon: Icons.mark_email_read_rounded,
      color: const Color(0xFFE2001A),
      buildTrackingUrl: (tn) =>
          'https://www.royalmail.com/track-your-item#/tracking-results/$tn',
    ),
  };

  static CarrierInfo? getCarrier(String carrierId) => _carriers[carrierId];

  static List<CarrierInfo> get allCarriers => _carriers.values.toList();

  /// Build a tracking URL for a carrier. Falls back to Google search.
  static String getTrackingUrl(String carrierId, String trackingNumber) {
    final carrier = _carriers[carrierId];
    if (carrier == null) {
      return 'https://www.google.com/search?q=$trackingNumber+tracking';
    }
    return carrier.buildTrackingUrl(trackingNumber);
  }

  /// Generic JS to auto-fill tracking input fields as a fallback.
  static String getAutoFillScript(String trackingNumber) {
    return '''
(function() {
  var tn = '$trackingNumber';
  var inputs = document.querySelectorAll('input');
  for (var i = 0; i < inputs.length; i++) {
    var input = inputs[i];
    var type = (input.type || '').toLowerCase();
    if (type === 'text' || type === 'search' || type === '') {
      var attrs = ((input.name || '') + (input.id || '') + (input.placeholder || '')).toLowerCase();
      if (attrs.includes('track') || attrs.includes('shipment') || attrs.includes('awb') || attrs.includes('search') || attrs.includes('number')) {
        input.value = tn;
        input.dispatchEvent(new Event('input', {bubbles: true}));
        input.dispatchEvent(new Event('change', {bubbles: true}));
        break;
      }
    }
  }
})();
''';
  }
}
