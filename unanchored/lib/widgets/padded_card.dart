import 'package:flutter/material.dart';

class PaddedCard extends StatelessWidget {
  final child;

  PaddedCard({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: child,
        ),
      ),
    );
  }
}
