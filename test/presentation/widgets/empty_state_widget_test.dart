import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/constants/app_constants.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/features/movies/presentation/widgets/empty_state_widget.dart';

void main() {
  group('EmptyStateWidget Tests', () {
    testWidgets('8. EmptyStateWidget displays icon and message', (WidgetTester tester) async {
      // Arrange
      const testMessage = 'No movies found';
      const testIcon = Icons.search_off;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: testIcon,
              message: testMessage,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byIcon(testIcon), findsOneWidget);
      expect(find.text(testMessage), findsOneWidget);
      
      final icon = tester.widget<Icon>(find.byIcon(testIcon));
      expect(icon.size, AppConstants.iconSizeXXLarge);
      expect(icon.color, AppColors.textHint);
    });

    testWidgets('9. EmptyStateWidget uses Column layout', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyStateWidget(
              icon: Icons.error_outline,
              message: 'Test message',
            ),
          ),
        ),
      );

      // Assert - Column is used for layout
      final column = find.byType(Column);
      expect(column, findsWidgets);
      
      // Assert - Content is aligned to center
      final columnWidget = tester.widget<Column>(column.first);
      expect(columnWidget.mainAxisAlignment, MainAxisAlignment.center);
    });
  });
}
