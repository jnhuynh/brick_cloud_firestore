import 'package:flutter/material.dart';

class PaddedContainer extends StatelessWidget {
  final child;
  final color;

  PaddedContainer({
    @required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.color ?? Colors.white,
      padding: EdgeInsets.all(10.0),
      child: child,
    );
  }
}
