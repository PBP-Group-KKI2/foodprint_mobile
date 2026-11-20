import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/models/analytics_summary.dart';
import 'package:foodprint_mobile/services/api_service.dart';
import 'package:foodprint_mobile/theme/app_theme.dart';
import 'package:foodprint_mobile/widgets/left_drawer.dart';
import 'package:foodprint_mobile/widgets/state_views.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late Future<AnalyticsSummary> _summary;

  @override
  void initState() {
    super.initState();
    _summary = ApiService.fetchAnalyticsSummary();
  }

  void _reload() {
    setState(() {
      _summary = ApiService.fetchAnalyticsSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<AnalyticsSummary>(
        future: _summary,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingView();
          }
          if (snapshot.hasError) {
            return ErrorView(error: snapshot.error!, onRetry: _reload);
          }
          final summary = snapshot.data!;
          if (summary.totalReports == 0) {
            return const EmptyView(
              icon: Icons.bar_chart_outlined,
              message:
                  'There are no reports yet, so there is nothing to summarise.',
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      label: 'Total reports',
                      value: summary.totalReports,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      label: 'Resolved',
                      value: summary.resolvedReports,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _BreakdownCard(
                title: 'By waste type',
                items: summary.byWasteType,
                total: summary.totalReports,
              ),
              const SizedBox(height: 12),
              _BreakdownCard(
                title: 'By severity',
                items: summary.bySeverity,
                total: summary.totalReports,
              ),
              const SizedBox(height: 12),
              _BreakdownCard(
                title: 'By city',
                items: summary.byCity,
                total: summary.totalReports,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: AppColors.inkSoft)),
            const SizedBox(height: 4),
            Text(
              '$value',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.green800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreakdownCard extends StatelessWidget {
  const _BreakdownCard({
    required this.title,
    required this.items,
    required this.total,
  });

  final String title;
  final List<CountItem> items;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            if (items.isEmpty)
              const Text(
                'No data.',
                style: TextStyle(color: AppColors.inkSoft),
              ),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(item.label)),
                        Text('${item.total}'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: item.total / total,
                      minHeight: 6,
                      color: AppColors.green600,
                      backgroundColor: AppColors.green100,
                      borderRadius: BorderRadius.circular(3),
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
