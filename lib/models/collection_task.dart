import 'package:foodprint_mobile/models/waste_report.dart';

class CollectionTask {
  const CollectionTask({
    required this.id,
    required this.report,
    required this.statusLabel,
    required this.isOpen,
    required this.scheduledFor,
    required this.notes,
  });

  final int id;
  final WasteReport report;
  final String statusLabel;
  final bool isOpen;
  final DateTime? scheduledFor;
  final String notes;

  factory CollectionTask.fromJson(Map<String, dynamic> json) => CollectionTask(
    id: json['id'] as int,
    report: WasteReport.fromJson(json['report'] as Map<String, dynamic>),
    statusLabel: json['status_label'] as String,
    isOpen: json['is_open'] as bool,
    scheduledFor: json['scheduled_for'] == null
        ? null
        : DateTime.parse(json['scheduled_for'] as String),
    notes: json['notes'] as String? ?? '',
  );
}
