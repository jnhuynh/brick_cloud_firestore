import 'package:flutter/material.dart';

typedef void OnRatingSelectCallback(dynamic rating);

class RatingBar extends StatelessWidget {
  final List<dynamic> ratings;
  final int selectedIndex;
  final OnRatingSelectCallback callback;

  RatingBar({
    @required this.ratings,
    this.selectedIndex,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = ratings
        .asMap()
        .map((index, rating) {
          final theme = Theme.of(context);

          final widget = RaisedButton(
            color: index == this.selectedIndex ? theme.primaryColor : theme.accentColor,
            shape: CircleBorder(),
            onPressed: () {
              callback(rating);
            },
            child: Center(
              child: Text(
                rating.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );

          return MapEntry(index, widget);
        })
        .values
        .toList();

    return Row(
      children: buttons,
    );
  }
}
