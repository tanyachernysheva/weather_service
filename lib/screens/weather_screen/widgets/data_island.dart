import 'package:flutter/material.dart';

class DataIsland extends StatelessWidget {
  final Widget? child;

  const DataIsland({
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}
