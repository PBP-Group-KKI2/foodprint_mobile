import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/models/user_profile.dart';
import 'package:foodprint_mobile/services/api_service.dart';
import 'package:foodprint_mobile/theme/app_theme.dart';
import 'package:foodprint_mobile/widgets/left_drawer.dart';
import 'package:foodprint_mobile/widgets/state_views.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<UserProfile> _profile;

  @override
  void initState() {
    super.initState();
    _profile = ApiService.fetchProfile();
  }

  void _reload() {
    setState(() {
      _profile = ApiService.fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      drawer: const LeftDrawer(),
      body: FutureBuilder<UserProfile>(
        future: _profile,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingView();
          }
          if (snapshot.hasError) {
            return ErrorView(error: snapshot.error!, onRetry: _reload);
          }
          final profile = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.green600,
                  child: Text(
                    profile.username[0].toUpperCase(),
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  profile.username,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Center(
                child: Text(
                  profile.roleLabel,
                  style: const TextStyle(color: AppColors.inkSoft),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.mail_outline),
                      title: const Text('Email'),
                      subtitle: Text(
                        profile.email.isEmpty ? 'Not set' : profile.email,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.stars_outlined),
                      title: const Text('Points'),
                      subtitle: Text('${profile.points}'),
                    ),
                    if (profile.showRank)
                      ListTile(
                        leading: const Icon(Icons.military_tech_outlined),
                        title: const Text('Rank'),
                        subtitle: Text(profile.rankLabel),
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
