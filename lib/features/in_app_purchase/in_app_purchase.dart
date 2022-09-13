import 'package:flutter/material.dart';
import './parental_gate.dart';
import './upgrade.dart';
import 'components.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/services.dart';

class InAppPurchase extends StatefulWidget {
  const InAppPurchase({Key? key}) : super(key: key);

  @override
  _InAppPurchaseState createState() => _InAppPurchaseState();
}

class _InAppPurchaseState extends State<InAppPurchase> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    appData.isPro = false;

    await Purchases.setDebugLogsEnabled(true);
    await Purchases.configure(PurchasesConfiguration(
        "goog_siZsXGACMJROLMrMsajYsKzHIpAoF")); // your_public_revenuecat_API_key

    CustomerInfo purchaserInfo;
    try {
      // fetches in-app purchase information about the device/user that is stored on Apple or Google servers.
      purchaserInfo = await Purchases.getCustomerInfo();
      print(purchaserInfo.toString());
      if (purchaserInfo.entitlements.all['all_features'] != null) {
        appData.isPro =
            purchaserInfo.entitlements.all['all_features']!.isActive;
      } else {
        appData.isPro = false;
      }
    } on PlatformException catch (e) {
      print(e);
    }

    print('#### Is pro user? ${appData.isPro}');
  }

  @override
  Widget build(BuildContext context) {
    return TopBarAgnosticNoIcon(
      text: 'In App Purchase',
      style: kSendButtonTextStyle,
      uniqueHeroTag: 'main',
      child: Scaffold(
        backgroundColor: kColorPrimary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Text(
                  'Welcome',
                  style: kSendButtonTextStyle.copyWith(fontSize: 40),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(color: kColorText)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Purchase a subscription',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                    onPressed: () {
                      if (appData.isPro!) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpgradeScreen(),
                                settings: const RouteSettings(
                                    name: 'Upgrade screen')));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ParentalGate(),
                                settings: const RouteSettings(
                                    name: 'Parental Gate')));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
