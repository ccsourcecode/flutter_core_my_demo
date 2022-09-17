import 'dart:async';

import 'package:battery_plus/battery_plus.dart';

import '../model/battery_information.dart';

class DeviceInformationService {
  bool _broadcastBattery = false;
  // keep battery class locally
  final Battery _battery = Battery();

// expose the Stream through a property
  Stream<BatteryInformation> get batteryLevel => _batteryLevelController.stream;

// setup StreamController
  final StreamController<BatteryInformation> _batteryLevelController =
      StreamController<BatteryInformation>();

// a while loop with the condition if _broadcastBattery is true.
// This will allow us to cancel this broadcast if needed.
  Future broadcastBatteryLevel() async {
    _broadcastBattery = true;
    while (_broadcastBattery) {
      // gets the batteryLevel
      var batteryLevel = await _battery.batteryLevel;
      // emits it over the stream then waits for 5 seconds.
      _batteryLevelController.add(BatteryInformation(batteryLevel));
      await Future.delayed(const Duration(seconds: 5));
    }
  }

// call it on dispose
  void stopBroadcast() {
    _broadcastBattery = false;
  }
}
