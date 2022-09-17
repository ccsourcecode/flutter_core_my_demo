import 'package:flutter/material.dart';
import '../avatar.dart';
import '../models/activity.dart';
import '../models/user.dart';

class ActivityCardHeader extends StatelessWidget {
  const ActivityCardHeader(
      {Key? key, required this.user, required this.activity})
      : super(key: key);
  final User user;
  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Avatar(radius: 15),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (user.displayName != null)
              Text(
                user.displayName,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            Text(
              activity.dateTime,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        )
      ],
    );
  }
}
