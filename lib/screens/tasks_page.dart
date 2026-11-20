import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/models/collection_task.dart';
import 'package:foodprint_mobile/services/api_service.dart';
import 'package:foodprint_mobile/utils/date_format.dart';
import 'package:foodprint_mobile/widgets/left_drawer.dart';
import 'package:foodprint_mobile/widgets/report_card.dart';
import 'package:foodprint_mobile/widgets/state_views.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late Future<List<CollectionTask>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = ApiService.fetchMyTasks();
  }

  void _reload() {
    setState(() {
      _tasks = ApiService.fetchMyTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Dispatch')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<CollectionTask>>(
        future: _tasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingView();
          }
          if (snapshot.hasError) {
            return ErrorView(error: snapshot.error!, onRetry: _reload);
          }
          final tasks = snapshot.data!;
          if (tasks.isEmpty) {
            return const EmptyView(
              icon: Icons.local_shipping_outlined,
              message: 'You have no open collection tasks.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final task = tasks[index];
              final scheduledFor = task.scheduledFor;
              return ReportCard(
                report: task.report,
                footer: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task: ${task.statusLabel}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    if (scheduledFor != null)
                      Text('Scheduled for ${formatDate(scheduledFor)}'),
                    if (task.notes.isNotEmpty) Text(task.notes),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
