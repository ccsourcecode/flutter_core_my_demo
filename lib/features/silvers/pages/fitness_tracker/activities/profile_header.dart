import 'package:flutter/material.dart';
import '../avatar.dart';
import '../models/user.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16.0),
        Avatar(photoUrl: user.photoUrl),
        const SizedBox(height: 8.0),
        if (user.displayName != null) ...[
          Text(
            user.displayName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8.0),
        ],
        if (user.username != null) ...[
          Text(
            user.username,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8.0),
        ],
      ],
    );
  }
}
