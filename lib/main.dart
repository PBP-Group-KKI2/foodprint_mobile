import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/screens/menu.dart';
import 'package:foodprint_mobile/theme/app_theme.dart';

void main() {
  runApp(const FoodPrintApp());
}

class FoodPrintApp extends StatelessWidget {
  const FoodPrintApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodPrint',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const MyHomePage(),
    );
  }
}
