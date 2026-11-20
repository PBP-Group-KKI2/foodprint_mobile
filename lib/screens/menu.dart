import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/modules.dart';
import 'package:foodprint_mobile/services/api_config.dart';
import 'package:foodprint_mobile/theme/app_theme.dart';
import 'package:foodprint_mobile/widgets/left_drawer.dart';
import 'package:foodprint_mobile/widgets/module_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FoodPrint')),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Food waste, mapped and acted on.',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.green800,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Report food waste around you, learn how to reduce it, '
              'and follow how your city is handling it.',
              style: TextStyle(color: AppColors.inkSoft),
            ),
            const SizedBox(height: 24),
            GridView.count(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                for (final module in appModules) ModuleCard(module: module),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Server: $baseUrl',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
