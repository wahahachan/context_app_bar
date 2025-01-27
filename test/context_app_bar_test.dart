import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:context_app_bar/context_app_bar.dart';

void main() {
  test('ContextAppBar initialized as a PreferredSizeWidget', () {
    final aCAB = ContextAppBar(
        appbarSelector: ValueNotifier<int>(0),
        children: [AppBar(key: ValueKey(0))]);
    expect(aCAB.preferredSize, Size.fromHeight(kToolbarHeight));
  });

  testWidgets('ContextAppBar initialized with 2 AppBar Widget', (tester) async {
    ValueNotifier<int> appbarSelector = ValueNotifier(0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: ContextAppBar(
            appbarSelector: appbarSelector,
            children: [
              AppBar(key: ValueKey(1), title: Text('The first appbar')),
              AppBar(key: ValueKey(2), title: Text('The second appbar')),
            ],
          ),
        ),
      ),
    );

    expect(find.text('The first appbar'), findsOneWidget);
    expect(find.text('The second appbar'), findsNothing);

    appbarSelector.value = 1;

    await tester.pump(Duration(milliseconds: 200));

    expect(find.text('The second appbar'), findsOneWidget);
  });

  testWidgets('Unselected appbar should disappear', (tester) async {
    ValueNotifier<int> appbarSelector = ValueNotifier(0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: ContextAppBar(
            appbarSelector: appbarSelector,
            animated: false,
            children: [
              AppBar(key: ValueKey(1), title: Text('The first appbar')),
              AppBar(key: ValueKey(2), title: Text('The second appbar')),
              AppBar(key: ValueKey(3), title: Text('The thrid appbar')),
              AppBar(
                key: ValueKey(4),
                title: Text('The fourth appbar'),
                actions: [
                  IconButton(onPressed: null, icon: Icon(Icons.time_to_leave)),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('The first appbar'), findsOneWidget);
    expect(find.text('The second appbar'), findsNothing);
    expect(find.text('The thrid appbar'), findsNothing);
    expect(find.text('The fourth appbar'), findsNothing);

    appbarSelector.value = 1;
    await tester.pump(Duration(milliseconds: 10));

    expect(find.text('The first appbar'), findsNothing);
    expect(find.text('The second appbar'), findsOneWidget);
    expect(find.text('The thrid appbar'), findsNothing);
    expect(find.text('The fourth appbar'), findsNothing);

    appbarSelector.value = 3;
    await tester.pump(Duration(milliseconds: 10));
    expect(find.text('The first appbar'), findsNothing);
    expect(find.text('The second appbar'), findsNothing);
    expect(find.text('The thrid appbar'), findsNothing);
    expect(find.text('The fourth appbar'), findsOneWidget);
    expect(
        find.widgetWithIcon(IconButton, Icons.time_to_leave), findsOneWidget);
  });

  testWidgets('Appbar switching by click', (tester) async {
    ValueNotifier<int> appbarSelector = ValueNotifier(3);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: ContextAppBar(
            appbarSelector: appbarSelector,
            animated: false,
            children: [
              AppBar(
                  key: ValueKey(1),
                  backgroundColor: Colors.green,
                  title: Text('The first appbar')),
              AppBar(
                  key: ValueKey(2),
                  backgroundColor: Colors.green,
                  title: Text('The second appbar')),
              AppBar(
                key: ValueKey(3),
                title: Text('The thrid appbar'),
                backgroundColor: Colors.red,
              ),
              AppBar(
                key: ValueKey(4),
                title: Text('The fourth appbar'),
                backgroundColor: Colors.blue,
                actions: [
                  IconButton(
                      onPressed: () {
                        appbarSelector.value = 2;
                      },
                      icon: Icon(Icons.time_to_leave)),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('The first appbar'), findsNothing);
    expect(find.text('The second appbar'), findsNothing);
    expect(find.text('The thrid appbar'), findsNothing);
    expect(find.text('The fourth appbar'), findsOneWidget);
    expect(
        find.widgetWithIcon(IconButton, Icons.time_to_leave), findsOneWidget);
    final currentAppbar4 = tester.widget<AppBar>(find.byType(AppBar));
    expect(currentAppbar4.backgroundColor, Colors.blue);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.time_to_leave));
    await tester.pump(Duration(milliseconds: 10));

    expect(find.text('The first appbar'), findsNothing);
    expect(find.text('The second appbar'), findsNothing);
    expect(find.text('The thrid appbar'), findsOneWidget);
    expect(find.text('The fourth appbar'), findsNothing);
    expect(find.widgetWithIcon(IconButton, Icons.time_to_leave), findsNothing);
    expect(find.byType(AppBar), findsOneWidget);
    final currentAppbar3 = tester.widget<AppBar>(find.byType(AppBar));
    expect(currentAppbar3.backgroundColor, Colors.red);
  });
}
