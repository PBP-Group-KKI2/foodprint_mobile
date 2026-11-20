import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:foodprint_mobile/main.dart';
import 'package:foodprint_mobile/modules.dart';
import 'package:foodprint_mobile/widgets/state_views.dart';

void main() {
  testWidgets('home page shows a card for every module', (tester) async {
    await tester.pumpWidget(const FoodPrintApp());

    expect(find.widgetWithText(AppBar, 'FoodPrint'), findsOneWidget);
    for (final module in appModules) {
      expect(find.text(module.title), findsOneWidget);
    }
  });

  for (final module in appModules) {
    testWidgets('drawer opens the ${module.title} page', (tester) async {
      await tester.pumpWidget(const FoodPrintApp());

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(
        find.descendant(
          of: find.byType(Drawer),
          matching: find.text(module.title),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.widgetWithText(AppBar, module.title), findsOneWidget);
      // Real HTTP calls fail inside widget tests, so each page should show its error state.
      expect(find.byType(ErrorView), findsOneWidget);
    });
  }

  testWidgets('module card opens its page and drawer Home returns', (
    tester,
  ) async {
    await tester.pumpWidget(const FoodPrintApp());
    await tester.ensureVisible(find.text('Analytics'));
    await tester.tap(find.text('Analytics'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Analytics'), findsOneWidget);

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'FoodPrint'), findsOneWidget);
  });
}
