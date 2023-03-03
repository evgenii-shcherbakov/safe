import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safe/di/app.module.dart';
import 'package:safe/widgets/components/loader.component.dart';

void main() async {
  await configureDependencies();
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Loader smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LoaderComponent());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
