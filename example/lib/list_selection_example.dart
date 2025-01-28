import 'package:flutter/material.dart';
import 'package:context_app_bar/context_app_bar.dart';

void main() {
  runApp(const MyApp());
}

// A globally defined integer, accessable in the builder function
ValueNotifier<int> appbarSelector = ValueNotifier(0);

// Globally defined selection states
int selectedCount = 0;
List<bool> selected = List<bool>.filled(8, false);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StatefulBuilder(builder: (context, setState) {
        return Scaffold(
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
                    onPressed: () {
                      // unselect all tiles and reset selection state
                      setState(() {
                        selectedCount = 0;
                        selected = List<bool>.filled(8, false);
                        appbarSelector.value = 0;
                      });
                    },
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
        );
      }),
    );
  }
}
