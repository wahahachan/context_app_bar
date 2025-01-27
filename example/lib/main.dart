import 'package:flutter/material.dart';
import 'package:context_app_bar/context_app_bar.dart';

void main() {
  runApp(const MyApp());
}

ValueNotifier<int> appbarSelector = ValueNotifier(0);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: ContextAppBar(
            appbarSelector: appbarSelector,
            children: [
              AppBar(key: ValueKey(1), title: Text('The first appbar')),
              AppBar(key: ValueKey(2), title: Text('The second appbar')),
              AppBar(key: ValueKey(3), title: Text('The thrid appbar')),
              AppBar(key: ValueKey(4), title: Text('The fourth appbar')),
            ],
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            appbarSelector.value = (appbarSelector.value + 1) % 4;
          })),
    );
  }
}
