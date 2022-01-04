import 'package:flutter/material.dart';

class BuildController<T> extends StatefulWidget {
  final Map<Type, Widget Function(T state)> actions;
  final Map<Type, void Function(T state, BuildContext context)>? listeners;
  final ValueNotifier<T> controller;
  final Function(T state)? buildWhen;
  const BuildController({
    Key? key,
    required this.actions,
    this.listeners,
    required this.controller,
    this.buildWhen,
  }) : super(key: key);

  @override
  State<BuildController<T>> createState() => _BuildControllerState<T>();
}

class _BuildControllerState<T> extends State<BuildController<T>> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      var action = widget.listeners?[widget.controller.value.runtimeType];
      if (action != null) {
        action(widget.controller.value, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Type? oldState;
    Widget oldWidget = const SizedBox.shrink();

    return ValueListenableBuilder<T>(
      valueListenable: widget.controller,
      builder: (context, value, child) {
        var state = value.runtimeType;

        var rebuild = widget.buildWhen?.call(value) ?? true;

        if (!rebuild) {
          return oldWidget;
        }

        var action = widget.actions[state];
        if (action != null) {
          oldState = state;
          return oldWidget = action(value);
        }

        if (oldState != null) {
          var action = widget.actions[oldState];
          if (action != null) {
            return oldWidget = action(value);
          }
        }
        return oldWidget;
      },
    );
  }
}
