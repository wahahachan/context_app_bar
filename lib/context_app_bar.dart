// Copyright 2025 JoeChan. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library;

import 'package:flutter/material.dart';

class ContextAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// Collects standard app bar widgets and displays one of them specificied
  /// by an index.
  ///
  /// The property [children] must contains one or more app bars.
  ///
  /// Typically used in the [Scaffold.appBar] property.
  ///
  /// The switching of app bar is triggered by changing the value of [appbarSelector].
  ///
  /// The [animated] flag enables the use of fade-in effect in between app bar switching.
  ///
  /// The [animationDuration] specifies the duration of of animation. If [animated]
  /// is set to false, this property is ignored.
  ///
  ContextAppBar({
    super.key,
    required this.appbarSelector,
    required this.children,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 280),
  })  : assert(children.isNotEmpty),
        preferredSize = children[0].preferredSize;

  /// A listenable that helps the widget to detects the need for switching app bar.
  /// The value of [appbarSelector] specifies the index of the app bar currently display.
  final ValueNotifier<int> appbarSelector;

  /// An array of app bar which can store any native implementation of flutter
  /// [ AppBar]. This widget displays one of the app bars specified by the
  /// integer [appbarSelector] as an index. All the [AppBar] must be **constructed
  /// by a unique key as [key]** in animated mode. Common way of creating a key
  /// includes [ValueKey], [UniqueKey], [ObjectKey] or [GlobalKey].
  ///
  /// Example:
  /// ```dart
  /// Scaffold(
  ///   appBar: ContextAppBar(
  ///     appbarSelector: appbarSelector,
  ///     children: [
  ///      AppBar(key: UniqueKey(), title: Text('The first appbar')),
  ///      AppBar(key: UniqueKey(), title: Text('The second appbar')),
  ///     ],
  ///   ),
  ///   // ...rest of body...
  /// )
  /// ```
  final List<PreferredSizeWidget> children;

  /// The [animated] flag enables the use of fade-in effect in between app bar switching.
  final bool animated;

  /// The [animationDuration] specifies the duration of of animation. If [animated]
  /// is set to false, this property is ignored.
  final Duration animationDuration;

  @override
  final Size preferredSize;

  @override
  State<ContextAppBar> createState() => _ContextAppBarState();
}

class _ContextAppBarState extends State<ContextAppBar> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.appbarSelector,
        builder: (context, _) {
          assert(
              (widget.appbarSelector.value >= 0 &&
                  widget.appbarSelector.value < widget.children.length),
              'Accessing the appbar array with an out-of-bounds index is detected '
              '(${widget.appbarSelector.value} out of ${widget.children.length}).');
          int effectiveAppBarIndex = widget.appbarSelector.value >= 0 &&
                  widget.appbarSelector.value < widget.children.length
              ? widget.appbarSelector.value
              : 0;
          return widget.animated
              ? AnimatedSwitcher(
                  duration: widget.animationDuration,
                  child: widget.children[effectiveAppBarIndex],
                )
              : widget.children[effectiveAppBarIndex];
        });
  }
}
