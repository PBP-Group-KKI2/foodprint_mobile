import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/models/waste_report.dart';
import 'package:foodprint_mobile/theme/app_theme.dart';
import 'package:foodprint_mobile/utils/date_format.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.report, this.footer});

  final WasteReport report;
  final Widget? footer;

  Color get _severityColor => switch (report.severity) {
    'HIGH' => AppColors.severityHigh,
    'MEDIUM' => AppColors.severityMedium,
    _ => AppColors.severityLow,
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    report.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Chip(
                  label: Text(report.severityLabel),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  backgroundColor: _severityColor,
                  side: BorderSide.none,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            Text('${report.wasteTypeLabel} · ${report.statusLabel}'),
            if (report.place.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  report.place,
                  style: const TextStyle(color: AppColors.inkSoft),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              'Reported by ${report.reporter} on ${formatDate(report.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (footer != null) ...[const Divider(height: 24), footer!],
          ],
        ),
      ),
    );
  }
}
