import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// This is a ValueListeneableBuilder that is capable of using three separate notifiers.
// it is in the common utils folder for its potential reusability, even if that would currently be out of scope
///Todo: naming could be improved

class ValueListenableBuilder3<A, B, C> extends StatelessWidget {
  const ValueListenableBuilder3({
    required this.first,
    required this.second,
    required this.third,
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final ValueListenable<C> third;
  final Widget? child;
  final Widget Function(BuildContext context, A a, B b, C c, Widget? child)
      builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<A>(
        valueListenable: first,
        builder: (_, a, __) {
          return ValueListenableBuilder<B>(
            valueListenable: second,
            builder: (_, b, __) {
              return ValueListenableBuilder<C>(
                valueListenable: third,
                builder: (context, c, __) {
                  return builder(context, a, b, c, child);
                },
              );
            },
          );
        },
      );
}
