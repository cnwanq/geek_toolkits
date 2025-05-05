import 'package:flutter/material.dart';
import '../core/state_signal.dart';

/// Flutter Widget 绑定扩展
class SignalBuilder<T> extends StatelessWidget {
  final StateSignal<T> signal;
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Widget? child;

  const SignalBuilder({
    Key? key,
    required this.signal,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: signal,
      builder: builder,
      child: child,
    );
  }
} 