class WasteReport {
  const WasteReport({
    required this.id,
    required this.title,
    required this.description,
    required this.wasteTypeLabel,
    required this.severity,
    required this.severityLabel,
    required this.statusLabel,
    required this.locationName,
    required this.city,
    required this.district,
    required this.reporter,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String description;
  final String wasteTypeLabel;
  final String severity;
  final String severityLabel;
  final String statusLabel;
  final String locationName;
  final String city;
  final String district;
  final String reporter;
  final DateTime createdAt;

  factory WasteReport.fromJson(Map<String, dynamic> json) => WasteReport(
    id: json['id'] as int,
    title: json['title'] as String,
    description: json['description'] as String? ?? '',
    wasteTypeLabel: json['waste_type_label'] as String,
    severity: json['severity'] as String,
    severityLabel: json['severity_label'] as String,
    statusLabel: json['status_label'] as String,
    locationName: json['location_name'] as String? ?? '',
    city: json['city'] as String? ?? '',
    district: json['district'] as String? ?? '',
    reporter: json['reporter'] as String,
    createdAt: DateTime.parse(json['created_at'] as String),
  );

  String get place => [
    locationName,
    district,
    city,
  ].where((part) => part.isNotEmpty).join(', ');
}
