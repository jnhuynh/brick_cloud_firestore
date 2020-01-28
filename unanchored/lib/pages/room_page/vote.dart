import 'package:flutter/material.dart';
import 'package:unanchored/widgets/widgets.dart';

class RoomPageVote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaddedContainer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildAmbiguityRating(context),
          _buildPoints(context),
        ],
      ),
    );
  }

  Widget _buildAmbiguityRating(context) {
    return PaddedCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Ambiguity',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.subtitle,
          ),
          FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
            child: RatingBar(
              ratings: [1, 2, 3, 4, 5],
              callback: (rating) {
                // TODO: store rating
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoints(BuildContext context) {
    // TODO: configurable API backed points buttons
    final possiblePoints = [1, 2, 3, 5, 8, 13];
    final List<Widget> pointCells = possiblePoints.map((point) {
      return RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          // TODO: add room has many story
          // TODO: add story has many votes
          // TODO: vote has ambiguity, complexity, point
          // TODO: add button select logic bloc
        },
        child: Center(
          child: Text(
            point.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }).toList();

    return Container(
      child: Expanded(
        child: GridView.count(
          primary: false,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: pointCells,
        ),
      ),
    );
  }
}
