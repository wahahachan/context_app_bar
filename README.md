Context app bar is a widget that helps creating an interactive app bar with native flutter app bar implementation.

![simple demo](https://github.com/wahahachan/context_app_bar/blob/main/example/example_gifs/float_button_simple.gif?raw=true)

## Features

* Incorporate flutter native app bar widget. You enjoy all the features provided by the original material app bar and is thus future-proof.
* Automatic and animated switching between app bars. (Optional animation, can be disabled)
* Easy to integrate. The switching is triggered by a value notifier, you don't need to worry about heavy and tangled message dispaching between widgets and the app bar.
* No other dependencies. This widget is built solely based on material flutter widget and follows common  implementation standard.

## Getting started

Follow these steps to use this package

### Add dependency

```yaml
dependencies:
  context_app_bar: ^1.0.0
```

### Add import package

```dart
import 'package:context_app_bar/context_app_bar.dart';
```

## Usage

Define a integer typed value notifier, this is our remote control. The app bar collection counts from zero.

```dart
ValueNotifier<int> appbarSelector = ValueNotifier(0);
```

The following shows a typically definition of material app bar. You **must** provide a unique key manually in order to use animated switching, which is enabled by default. Common ways of adding a key inclue `ValueKey`, `UniqueKey`, `ObjectKey` or `GlobalKey`. You can learn more [here](https://api.flutter.dev/flutter/foundation/Key-class.html).

```dart
AppBar(
  key: UniqueKey(), // Any key that is unique to other app bars
  title: Text('The first appbar'),
  backgroundColor: Colors.green,
),
```

Warp the original `AppBar` widget with the `ContextAppBar` widget like this.

Turns

```dart
Scaffold(
  appBar: AppBar(
    key: UniqueKey(), // Any key that is unique to other app bars
    title: Text('The first appbar'),
    backgroundColor: Colors.green),
  body: // .... rest of the application
),
```

into

```dart
Scaffold(
  appBar: ContextAppBar(
    appbarSelector: appbarSelector,
    children: [
      AppBar(
        key: UniqueKey(), // The first app bar
        title: Text('The first appbar'),
        backgroundColor: Colors.green),
      AppBar(
        key: UniqueKey(), // Another app bar that feels good
        title: Text('The second appbar'),
        backgroundColor: Colors.red),
    ],
  ),
  body: // .... rest of the application
),
```

Let's assums you would like to switch to another `AppBar` when users click a floating action button. Just assign a new value to the `appbarSelector` variable.

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () {
    appbarSelector.value = (appbarSelector.value + 1) % 2;  // Switching between 2 app bars
  },
  child: Icon(Icons.add),
)
```

And you are good to go.

![simple demo](https://file+.vscode-resource.vscode-cdn.net/home/joe/learn/ContextualAppBar/context_app_bar/example/example_gifs/float_button_simple.gif)

## Complete sample code

```dart
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
```

## Last but not least...

Please feel free to report any issues or suggest improvements.

A more detailed example that shows a contextual app bar switching based on selected items can be found [here](https://github.com/wahahachan/context_app_bar/tree/main/example).

![select listed item demo](https://github.com/wahahachan/context_app_bar/blob/main/example/example_gifs/list_selection_demo.gif?raw=true)
