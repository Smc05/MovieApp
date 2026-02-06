import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/movies/presentation/widgets/search_bar_widget.dart';

void main() {
  group('SearchBarWidget Tests', () {
    testWidgets('10. SearchBarWidget displays and accepts input', (
      WidgetTester tester,
    ) async {
      // Arrange
      final controller = TextEditingController();
      String? changedValue;
      var clearCalled = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchBarWidget(
              controller: controller,
              onChanged: (value) => changedValue = value,
              onClear: () => clearCalled = true,
            ),
          ),
        ),
      );

      // Assert - Search icon is visible
      expect(find.byIcon(Icons.search), findsOneWidget);

      // Act - Type in search field
      await tester.enterText(find.byType(TextField), 'Inception');
      await tester.pump();

      // Assert - Text is entered and callback is called
      expect(controller.text, 'Inception');
      expect(changedValue, 'Inception');
      expect(clearCalled, false);
    });

    testWidgets('11. SearchBarWidget clear button works', (
      WidgetTester tester,
    ) async {
      // Arrange
      final controller = TextEditingController(text: 'Test');
      var clearCalled = false;

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchBarWidget(
              controller: controller,
              onChanged: (value) {},
              onClear: () => clearCalled = true,
            ),
          ),
        ),
      );

      // Rebuild to show clear button
      await tester.pump();

      // Assert - Clear button should be visible when text exists
      final clearButton = find.byIcon(Icons.clear);
      expect(clearButton, findsOneWidget);

      // Act - Tap clear button
      await tester.tap(clearButton);
      await tester.pump();

      // Assert - Clear callback is called
      expect(clearCalled, true);
    });

    testWidgets('12. SearchBarWidget displays custom hint text', (
      WidgetTester tester,
    ) async {
      // Arrange
      final controller = TextEditingController();
      const customHint = 'Search for awesome movies...';

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchBarWidget(
              controller: controller,
              onChanged: (value) {},
              onClear: () {},
              hintText: customHint,
            ),
          ),
        ),
      );

      // Assert - Custom hint text is displayed
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.hintText, customHint);
    });
  });
}
