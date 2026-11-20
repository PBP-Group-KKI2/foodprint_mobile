import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/modules.dart';
import 'package:foodprint_mobile/screens/menu.dart';
import 'package:foodprint_mobile/theme/app_theme.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.green800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'FoodPrint',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Report, track, and learn about food waste.',
                  style: TextStyle(color: AppColors.green100),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
          ),
          for (final module in appModules)
            ListTile(
              leading: Icon(module.icon),
              title: Text(module.title),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => module.page),
                );
              },
            ),
        ],
      ),
    );
  }
}
