import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/models/waste_report.dart';
import 'package:foodprint_mobile/services/api_service.dart';
import 'package:foodprint_mobile/widgets/left_drawer.dart';
import 'package:foodprint_mobile/widgets/report_card.dart';
import 'package:foodprint_mobile/widgets/state_views.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late Future<List<WasteReport>> _reports;

  @override
  void initState() {
    super.initState();
    _reports = ApiService.fetchReports();
  }

  void _reload() {
    setState(() {
      _reports = ApiService.fetchReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Waste Reports')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<WasteReport>>(
        future: _reports,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingView();
          }
          if (snapshot.hasError) {
            return ErrorView(error: snapshot.error!, onRetry: _reload);
          }
          final reports = snapshot.data!;
          if (reports.isEmpty) {
            return const EmptyView(
              icon: Icons.place_outlined,
              message: 'No food waste has been reported yet.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reports.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) => ReportCard(report: reports[index]),
          );
        },
      ),
    );
  }
}
