This example will walk you through how to create a contextual app bar that can react to user selections.

To start with, define a value notifier that act as a remote control, together with some state variables. They can lying within any scope as long as your widgets have access to them.

```dart
// A globally defined integer, accessable in the builder function
ValueNotifier<int> appbarSelector = ValueNotifier(0);

// Globally defined selection states
int selectedCount = 0;
List<bool> selected = List<bool>.filled(8, false);
```

In this application, we would like to have 2 app bars, one shows the app title while the other shows the number of items selected. The later app bar only appears if a user selected at least one listed item by long pressing.

```dart
Scaffold(
  appBar: ContextAppBar(
    appbarSelector: appbarSelector,
    children: [
      AppBar(
        key: UniqueKey(), // Any key that is unique to other app bars
        title: const Text('Demo app'),
        backgroundColor: Colors.green,
      ),
      AppBar(
        key: UniqueKey(), // Any key that is unique to other app bars
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.close)),
        // A dynamic title to show the current count of selected tile
        title: Text(' $selectedCount selected'),
        backgroundColor: Colors.lightGreen,
        actions: [
          // Add any action that fits appliction context in the native way
          IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
          IconButton(onPressed: () {}, icon: Icon(Icons.check_box)),
          SizedBox(width: 20),
        ],
      ),
    ],
  ),
  body: // .... rest of the application
```

In the body, define a `ListView` and add a few `ListTile`s where each of them are indexed and would respond to long press gesture.

```dart
body: Center(
child: ListView(
  children: [
    for (int i = 0; i < 8; i++)
      ListTile(
        onLongPress: () {
          // (Un)Selected this tile
          setState(() {
            selectedCount += selected[i] ? -1 : 1;
            selected[i] = !selected[i];
            appbarSelector.value = selectedCount > 0 ? 1 : 0;
          });
        },
        title: Text('My friend #$i'),
        // show trailing check box if at least one of the tiles is selected
        trailing: selectedCount > 0
            ? Checkbox(
                value: selected[i],
                onChanged: (_) {
                  setState(() {
                    selectedCount += selected[i] ? -1 : 1;
                    selected[i] = !selected[i];
                    appbarSelector.value =
                        selectedCount > 0 ? 1 : 0;
                  });
                })
            : null,
      )
  ],
),
),
```

This statement `appbarSelector.value = selectedCount > 0 ? 1 : 0` triggers the contextual app bar to switch to the second app bar(indexed as 1), when the number of selected items is greater than `0`.

![select listed item demo](https://github.com/wahahachan/context_app_bar/blob/main/example/example_gifs/list_selection_demo.gif?raw=true)

A complete code sample of this tutorial can be found in the [list_selection_example.dart](https://github.com/wahahachan/context_app_bar/blob/main/example/lib/list_selection_example.dart).
