import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SliderApp extends StatelessWidget {
  const SliderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Slide Tile',
      home: Scaffold(
        body: Align(alignment: Alignment.bottomCenter, child: ProfileBanner()),
      ),
    );
  }
}

class ProfileBanner extends StatelessWidget {
  const ProfileBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: const [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: const ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: doNothing,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 6,
              offset: const Offset(0, -2))
        ]),
        child: const ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(
              Icons.supervised_user_circle,
              color: Colors.white,
            ),
          ),
          trailing: Icon(Icons.arrow_left),
          title: Text('FilledStacks'),
          subtitle: Text('Flutter Applications Developer'),
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
