// Базовый тест Flutter-приложения.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/app.dart';

void main() {
  testWidgets('Приложение запускается без ошибок', (WidgetTester tester) async {
    // Запускаем приложение с ProviderScope
    await tester.pumpWidget(const ProviderScope(child: App()));
    // Проверяем, что приложение отрендерилось
    expect(find.byType(ProviderScope), findsOneWidget);
  });
}
