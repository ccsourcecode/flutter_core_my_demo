import 'package:flutter/material.dart';
import '../../enums/connectivity_status.dart';
import 'package:provider/provider.dart';

// This widget will provide "Network sensitivity" to any widget it's wrapped around.
class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;

  const NetworkSensitive({
    super.key,
    required this.child,
    this.opacity = 0.5, // make it semi-transparent
  });

  @override
  Widget build(BuildContext context) {
    // Get connection status anywhere in the app with the provider
    // show different child base on connection status
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.WiFi) {
      return child;
    }

    if (connectionStatus == ConnectivityStatus.Cellular) {
      return Opacity(
        opacity: opacity,
        child: child,
      );
    }

    // offline
    return Opacity(
      opacity: 0.1,
      child: child,
    );
  }
}
