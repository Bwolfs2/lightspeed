import 'package:flutter/cupertino.dart';
import 'package:lightspeed/lightspeed.dart';

extension ValueNotifierExtension on ValueNotifier {
  Widget build<T extends Object>(
      {required Map<Type, Widget Function(T state)> actions, Map<Type, void Function(T state, BuildContext context)>? listeners}) {
    return BuildController<T>(actions: actions, controller: this as ValueNotifier<T>);
  }
}
