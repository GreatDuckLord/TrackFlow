/// A lightweight model for saved tracking lookups.
class TrackingEntry {
  final String trackingNumber;
  final String carrierId;
  final String carrierName;
  final DateTime createdAt;

  const TrackingEntry({
    required this.trackingNumber,
    required this.carrierId,
    required this.carrierName,
    required this.createdAt,
  });

  String get id => '${carrierId}_$trackingNumber';

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'carrierId': carrierId,
        'carrierName': carrierName,
        'createdAt': createdAt.toIso8601String(),
      };

  factory TrackingEntry.fromJson(Map<String, dynamic> json) => TrackingEntry(
        trackingNumber: json['trackingNumber'],
        carrierId: json['carrierId'],
        carrierName: json['carrierName'],
        createdAt: DateTime.parse(json['createdAt']),
      );
}
