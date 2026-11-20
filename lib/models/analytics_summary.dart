class CountItem {
  const CountItem({required this.label, required this.total});

  final String label;
  final int total;

  factory CountItem.fromJson(Map<String, dynamic> json) =>
      CountItem(label: json['label'] as String, total: json['total'] as int);
}

class AnalyticsSummary {
  const AnalyticsSummary({
    required this.totalReports,
    required this.resolvedReports,
    required this.byWasteType,
    required this.bySeverity,
    required this.byCity,
  });

  final int totalReports;
  final int resolvedReports;
  final List<CountItem> byWasteType;
  final List<CountItem> bySeverity;
  final List<CountItem> byCity;

  factory AnalyticsSummary.fromJson(Map<String, dynamic> json) =>
      AnalyticsSummary(
        totalReports: json['total_reports'] as int,
        resolvedReports: json['resolved_reports'] as int,
        byWasteType: _counts(json['by_waste_type']),
        bySeverity: _counts(json['by_severity']),
        byCity: _counts(json['by_city']),
      );

  static List<CountItem> _counts(dynamic items) => (items as List<dynamic>)
      .map((item) => CountItem.fromJson(item as Map<String, dynamic>))
      .toList();
}
