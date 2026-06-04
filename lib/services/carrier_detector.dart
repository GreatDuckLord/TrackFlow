/// Auto-detects the likely carrier from a tracking number format.
class CarrierDetector {
  /// Returns a list of likely carrier IDs sorted by confidence.
  /// Returns empty list if no match found.
  static List<String> detect(String trackingNumber) {
    final tn = trackingNumber.replaceAll(RegExp(r'[\s\-]'), '').toUpperCase();
    final matches = <String>[];

    // FedEx patterns
    if (_isFedEx(tn)) matches.add('fedex');

    // UPS patterns
    if (_isUPS(tn)) matches.add('ups');

    // DHL patterns
    if (_isDHL(tn)) matches.add('dhl');

    // USPS patterns
    if (_isUSPS(tn)) matches.add('usps');

    // Aramex patterns
    if (_isAramex(tn)) matches.add('aramex');

    // Amazon patterns
    if (_isAmazon(tn)) matches.add('amazon');

    // La Poste / Colissimo
    if (_isLaPoste(tn)) matches.add('laposte');

    // Royal Mail
    if (_isRoyalMail(tn)) matches.add('royalmail');

    return matches;
  }

  static bool _isFedEx(String tn) {
    // FedEx Express: 12 digits
    if (RegExp(r'^\d{12}$').hasMatch(tn)) return true;
    // FedEx Ground: 15 digits
    if (RegExp(r'^\d{15}$').hasMatch(tn)) return true;
    // FedEx Ground (96): 20-22 digits starting with 96
    if (RegExp(r'^96\d{18,20}$').hasMatch(tn)) return true;
    // Door Tag: starts with DT
    if (RegExp(r'^DT\d{12}$').hasMatch(tn)) return true;
    return false;
  }

  static bool _isUPS(String tn) {
    // UPS: 1Z + 6 alphanumeric + 2 digits + 8 digits
    if (RegExp(r'^1Z[A-Z0-9]{16}$').hasMatch(tn)) return true;
    // UPS Mail Innovations: starts with MI
    if (RegExp(r'^MI\d{6}').hasMatch(tn)) return true;
    // UPS Freight: starts with H
    if (RegExp(r'^H\d{10}$').hasMatch(tn)) return true;
    return false;
  }

  static bool _isDHL(String tn) {
    // DHL Express: 10 digits
    if (RegExp(r'^\d{10}$').hasMatch(tn)) return true;
    // DHL Express: starts with JD followed by 18 digits
    if (RegExp(r'^JD\d{18}$').hasMatch(tn)) return true;
    // DHL eCommerce: GM, LX, RX + digits
    if (RegExp(r'^(GM|LX|RX)\d+$').hasMatch(tn)) return true;
    // DHL Parcel: 3S + digits
    if (RegExp(r'^3S\d+$').hasMatch(tn)) return true;
    // DHL JVGL
    if (RegExp(r'^JVGL\d+$').hasMatch(tn)) return true;
    return false;
  }

  static bool _isUSPS(String tn) {
    // USPS: 20-22 digits (many formats)
    if (RegExp(r'^\d{20,22}$').hasMatch(tn)) return true;
    // USPS: starts with 94 + 18-20 digits
    if (RegExp(r'^94\d{18,20}$').hasMatch(tn)) return true;
    // USPS: 2 letters + 9 digits + US
    if (RegExp(r'^[A-Z]{2}\d{9}US$').hasMatch(tn)) return true;
    // Priority Mail Express: EA-EZ + 9 digits + US
    if (RegExp(r'^E[A-Z]\d{9}US$').hasMatch(tn)) return true;
    return false;
  }

  static bool _isAramex(String tn) {
    // Aramex: typically 8-digit numbers or alphanumeric
    if (RegExp(r'^\d{8}$').hasMatch(tn)) return true;
    // Aramex international: varied alphanumeric 10-20 chars
    if (RegExp(r'^\d{10,13}$').hasMatch(tn)) return true;
    // Aramex with prefix
    if (RegExp(r'^(ARX|ARA)\d+$', caseSensitive: false).hasMatch(tn)) return true;
    return false;
  }

  static bool _isAmazon(String tn) {
    // Amazon: TBA + digits
    if (RegExp(r'^TBA\d{10,15}$').hasMatch(tn)) return true;
    return false;
  }

  static bool _isLaPoste(String tn) {
    // Colissimo: 2 letters + 9 digits + FR
    if (RegExp(r'^[A-Z]{2}\d{9}FR$').hasMatch(tn)) return true;
    // La Poste: 13 digits
    if (RegExp(r'^\d{13}$').hasMatch(tn)) return true;
    return false;
  }

  static bool _isRoyalMail(String tn) {
    // Royal Mail: 2 letters + 9 digits + GB
    if (RegExp(r'^[A-Z]{2}\d{9}GB$').hasMatch(tn)) return true;
    return false;
  }

  /// Get a human-readable name for a carrier ID
  static String carrierName(String carrierId) {
    switch (carrierId) {
      case 'fedex':
        return 'FedEx';
      case 'ups':
        return 'UPS';
      case 'dhl':
        return 'DHL';
      case 'usps':
        return 'USPS';
      case 'aramex':
        return 'Aramex';
      case 'amazon':
        return 'Amazon Logistics';
      case 'laposte':
        return 'La Poste / Colissimo';
      case 'royalmail':
        return 'Royal Mail';
      default:
        return carrierId;
    }
  }
}
