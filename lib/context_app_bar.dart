import 'package:flutter/widgets.dart';

class ContextAppBar extends StatefulWidget implements PreferredSizeWidget {
  ContextAppBar({
    super.key,
    required this.appbarSelector,
    required this.children,
    this.animated = true,
    this.animationDuration = const Duration(milliseconds: 280),
  })  : assert(children.isNotEmpty),
        preferredSize = children[0].preferredSize;

  final ValueNotifier<int> appbarSelector;
  final List<PreferredSizeWidget> children;
  final bool animated;
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
