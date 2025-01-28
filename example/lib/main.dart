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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: ContextAppBar(
          appbarSelector: appbarSelector,
          children: [
            AppBar(
                key: UniqueKey(), // Any key that is unique to other app bars
                title: Text('The first appbar'),
                backgroundColor: Colors.green),
            AppBar(
                key: UniqueKey(),
                title: Text('The second appbar'),
                backgroundColor: Colors.red),
            AppBar(
                key: UniqueKey(),
                title: Text('The thrid appbar'),
                backgroundColor: Colors.blue),
            AppBar(
                key: UniqueKey(),
                title: Text('The fourth appbar'),
                backgroundColor: Colors.grey),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            appbarSelector.value = (appbarSelector.value + 1) % 4;
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
