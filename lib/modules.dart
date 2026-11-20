import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/screens/analytics_page.dart';
import 'package:foodprint_mobile/screens/articles_page.dart';
import 'package:foodprint_mobile/screens/profile_page.dart';
import 'package:foodprint_mobile/screens/reports_page.dart';
import 'package:foodprint_mobile/screens/rewards_page.dart';
import 'package:foodprint_mobile/screens/tasks_page.dart';
import 'package:foodprint_mobile/theme/app_theme.dart';

class AppModule {
  const AppModule({
    required this.title,
    required this.icon,
    required this.color,
    required this.page,
  });

  final String title;
  final IconData icon;
  final Color color;
  final Widget page;
}

const List<AppModule> appModules = [
  AppModule(
    title: 'Waste Reports',
    icon: Icons.place_outlined,
    color: AppColors.green600,
    page: ReportsPage(),
  ),
  AppModule(
    title: 'Profile',
    icon: Icons.person_outline,
    color: AppColors.green700,
    page: ProfilePage(),
  ),
  AppModule(
    title: 'Rewards',
    icon: Icons.emoji_events_outlined,
    color: AppColors.amber,
    page: RewardsPage(),
  ),
  AppModule(
    title: 'Educational Hub',
    icon: Icons.menu_book_outlined,
    color: AppColors.green800,
    page: ArticlesPage(),
  ),
  AppModule(
    title: 'Analytics',
    icon: Icons.bar_chart_outlined,
    color: AppColors.green500,
    page: AnalyticsPage(),
  ),
  AppModule(
    title: 'Task Dispatch',
    icon: Icons.local_shipping_outlined,
    color: AppColors.green900,
    page: TasksPage(),
  ),
];
