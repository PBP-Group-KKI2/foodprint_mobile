import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/models/reward_status.dart';
import 'package:foodprint_mobile/services/api_service.dart';
import 'package:foodprint_mobile/theme/app_theme.dart';
import 'package:foodprint_mobile/widgets/left_drawer.dart';
import 'package:foodprint_mobile/widgets/state_views.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({super.key});

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  late Future<RewardStatus> _rewards;

  @override
  void initState() {
    super.initState();
    _rewards = ApiService.fetchRewards();
  }

  void _reload() {
    setState(() {
      _rewards = ApiService.fetchRewards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rewards')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<RewardStatus>(
        future: _rewards,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingView();
          }
          if (snapshot.hasError) {
            return ErrorView(error: snapshot.error!, onRetry: _reload);
          }
          final rewards = snapshot.data!;
          final nextRank = rewards.nextRank;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: AppColors.green800,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'Your points',
                        style: TextStyle(color: AppColors.green100),
                      ),
                      Text(
                        '${rewards.points}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${rewards.rankLabel} rank',
                        style: const TextStyle(
                          color: AppColors.amber,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.trending_up),
                      title: Text(
                        nextRank == null
                            ? 'Top rank reached'
                            : 'Next rank: $nextRank',
                      ),
                      subtitle: nextRank == null
                          ? null
                          : Text(
                              '${rewards.pointsToNextRank} more points to go',
                            ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.add_location_alt_outlined),
                      title: const Text('Each report you post earns'),
                      subtitle: Text('${rewards.pointsPerReport} points'),
                    ),
                    ListTile(
                      leading: Icon(
                        rewards.showRank
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      title: const Text('Rank on your profile'),
                      subtitle: Text(rewards.showRank ? 'Shown' : 'Hidden'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
