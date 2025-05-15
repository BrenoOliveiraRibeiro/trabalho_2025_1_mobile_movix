class Delivery {
  final String id;
  final String status;
  final String address;
  final DateTime timestamp;
  final String? photoPath;
  final double? latitude;
  final double? longitude;

  Delivery({
    required this.id,
    required this.status,
    required this.address,
    required this.timestamp,
    this.photoPath,
    this.latitude,
    this.longitude,
  });
}
