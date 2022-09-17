import 'dart:async';

import '../services/button_message_bus.dart';
import 'package:flutter/material.dart';
import '../service_locator.dart';

class ConnectedButton extends StatefulWidget {
  final int id;

  const ConnectedButton({super.key, required this.id});

  @override
  _ConnectedButtonState createState() => _ConnectedButtonState();
}

class _ConnectedButtonState extends State<ConnectedButton> {
  bool _active = false;
  double _size = 100;

// use the locator to get our MessageBus
  final ButtonMessagebus _messageBus = locator<ButtonMessagebus>();
  late StreamSubscription<int> messageSubscription;

  @override
  void initState() {
    // Listen for Id received (subscribe to the id's being emitted) and perform your custom logic
    messageSubscription = _messageBus.idStream.listen(_idReceived);
    super.initState();
  }

// changes it's width and height depending on the id coming from the stream.
// If the ID matches we want to grow, else we shrink.
  void _idReceived(int id) {
    setState(() {
      if (id == widget.id) {
        _active = true;
        _size = 140;
      } else {
        _active = false;
        _size = 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Broadcast Id
        _messageBus.broadcastId(widget.id);
      },
      child: _buttonUi,
    );
  }

  @override
  void dispose() {
    super.dispose();
    messageSubscription.cancel();
  }

  Widget get _buttonUi => AnimatedContainer(
        curve: Curves.easeIn,
        width: _size,
        height: _size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[500], borderRadius: BorderRadius.circular(10.0)),
        duration: const Duration(milliseconds: 150),
        child: Text(
          'id: ${widget.id} -> ${_active.toString()}',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      );
}
