import 'package:core_example/features/battery_info/model/battery_information.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/device_information_service.dart';

class BatteryInfoApp extends StatelessWidget {
  const BatteryInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<BatteryInformation>(
      create: (_) {
        return DeviceInformationService().batteryLevel;
      },
      initialData: BatteryInformation(100),
      // builder: (BuildContext context) =>
      //     DeviceInformationService().batteryLevel,
      child: MaterialApp(title: 'Flutter Demo', home: BatteryView()),
    );
  }
}

class BatteryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var batteryInformation = Provider.of<BatteryInformation>(context);
    return Scaffold(
      body: Center(
        child: Text('Battery Level: ${batteryInformation.batteryLevel}'),
      ),
    );
  }
}
