import 'package:flutter/material.dart';
import 'dart:async';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/services.dart';
import 'components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'pro_screen.dart';
import 'purchase_button.dart';

/// handle in-app purchase transactions
class UpgradeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  Offerings? _offerings;
  CustomerInfo? _customerInfo;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    CustomerInfo? customerInfo;

    try {
      customerInfo = await Purchases.getCustomerInfo();
    } on PlatformException catch (e) {
      print(e);
    }

// fetch the configured Offerings and retrieve the product information
// from Apple, Google, or Amazon.
// Thus, available products will already be loaded when customers launch your purchase screen.
    Offerings? offerings;
    try {
      offerings = await Purchases.getOfferings();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _customerInfo = customerInfo;
      _offerings = offerings;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_customerInfo == null) {
      return TopBarAgnosticNoIcon(
        text: "Upgrade Screen",
        style: kSendButtonTextStyle,
        uniqueHeroTag: 'upgrade_screen',
        child: const Scaffold(
            backgroundColor: kColorPrimary,
            body: Center(
                child: Text(
              "Loading...",
            ))),
      );
    } else {
      if (_customerInfo!.entitlements.all.isNotEmpty) {
        appData.isPro =
            _customerInfo!.entitlements.all['all_features']!.isActive;
      } else {
        appData.isPro = false;
      }

      if (appData.isPro!) {
        return ProScreen();
      } else {
        return UpsellScreen(
          offerings: _offerings!,
        );
      }
    }
  }
}

class UpsellScreen extends StatefulWidget {
  final Offerings offerings;

  const UpsellScreen({Key? key, required this.offerings}) : super(key: key);

  @override
  _UpsellScreenState createState() => _UpsellScreenState();
}

class _UpsellScreenState extends State<UpsellScreen> {
  _launchURLWebsite(String zz) async {
    if (await canLaunch(zz)) {
      await launch(zz);
    } else {
      throw 'Could not launch $zz';
    }
  }

  @override
  Widget build(BuildContext context) {
    print('offeringS is not null');
    print(widget.offerings.current.toString());
    print('--');
    print(widget.offerings.toString());
    final offering = widget.offerings.current;
    if (offering != null) {
      final monthly = offering.monthly;
      if (monthly != null) {
        return TopBarAgnosticNoIcon(
          text: "Upgrade Screen",
          style: kSendButtonTextStyle,
          uniqueHeroTag: 'purchase_screen',
          child: Scaffold(
              backgroundColor: kColorPrimary,
              body: Center(
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Thanks for your interest in our app!',
                      textAlign: TextAlign.center,
                      style: kSendButtonTextStyle,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: CircleAvatar(
                        backgroundColor: kColorPrimary,
                        radius: 45.0,
                        backgroundImage:
                            AssetImage("assets/images/avatar_demo.png"),
                      ),
                    ),
                    Text(
                      'Choose one of the plan to continue to get access to all the app content.\n',
                      textAlign: TextAlign.center,
                      style: kSendButtonTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PurchaseButton(package: monthly),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GestureDetector(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: kColorPrimaryDark,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              'Restore Purchase',
                              style: kSendButtonTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          try {
                            print('now trying to restore');
                            CustomerInfo restoredInfo =
                                await Purchases.restorePurchases();
                            print('restore completed');
                            print(restoredInfo.toString());

                            appData.isPro = restoredInfo
                                .entitlements.all["all_features"]!.isActive;

                            print('is user pro? ${appData.isPro}');

                            if (appData.isPro!) {
                              Alert(
                                context: context,
                                style: kWelcomeAlertStyle,
                                image: Image.asset(
                                  "assets/images/avatar_demo.png",
                                  height: 150,
                                ),
                                title: "Congratulation",
                                content: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0,
                                          right: 8.0,
                                          left: 8.0,
                                          bottom: 20.0),
                                      child: Text(
                                        'Your purchase has been restored!',
                                        textAlign: TextAlign.center,
                                        style: kSendButtonTextStyle,
                                      ),
                                    )
                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    radius: BorderRadius.circular(10),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    width: 127,
                                    color: kColorAccent,
                                    height: 52,
                                    child: Text(
                                      "COOL",
                                      style: kSendButtonTextStyle,
                                    ),
                                  ),
                                ],
                              ).show();
                            } else {
                              Alert(
                                context: context,
                                style: kWelcomeAlertStyle,
                                image: Image.asset(
                                  "assets/images/avatar_demo.png",
                                  height: 150,
                                ),
                                title: "Error",
                                content: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0,
                                          right: 8.0,
                                          left: 8.0,
                                          bottom: 20.0),
                                      child: Text(
                                        'There was an error. Please try again later',
                                        textAlign: TextAlign.center,
                                        style: kSendButtonTextStyle,
                                      ),
                                    )
                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    radius: BorderRadius.circular(10),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    width: 127,
                                    color: kColorAccent,
                                    height: 52,
                                    child: Text(
                                      "COOL",
                                      style: kSendButtonTextStyle,
                                    ),
                                  ),
                                ],
                              ).show();
                            }
                          } on PlatformException catch (e) {
                            print('----xx-----');
                            var errorCode =
                                PurchasesErrorHelper.getErrorCode(e);
                            if (errorCode ==
                                PurchasesErrorCode.purchaseCancelledError) {
                              print("User cancelled");
                            } else if (errorCode ==
                                PurchasesErrorCode.purchaseNotAllowedError) {
                              print("User not allowed to purchase");
                            }
                            Alert(
                              context: context,
                              style: kWelcomeAlertStyle,
                              image: Image.asset(
                                "assets/images/avatar_demo.png",
                                height: 150,
                              ),
                              title: "Error",
                              content: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0,
                                        right: 8.0,
                                        left: 8.0,
                                        bottom: 20.0),
                                    child: Text(
                                      'There was an error. Please try again later',
                                      textAlign: TextAlign.center,
                                      style: kSendButtonTextStyle,
                                    ),
                                  )
                                ],
                              ),
                              buttons: [
                                DialogButton(
                                  radius: BorderRadius.circular(10),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  width: 127,
                                  color: kColorAccent,
                                  height: 52,
                                  child: Text(
                                    "COOL",
                                    style: kSendButtonTextStyle,
                                  ),
                                ),
                              ],
                            ).show();
                          }
                          // return UpgradeScreen();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GestureDetector(
                        onTap: () {
                          _launchURLWebsite('https://google.com');
                        },
                        child: Text(
                          'Privacy Policy (click to read)',
                          style: kSendButtonTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: GestureDetector(
                        onTap: () {
                          _launchURLWebsite('https://yahoo.com');
                        },
                        child: Text(
                          'Term of Use (click to read)',
                          style: kSendButtonTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              )),
        );
      }
    }
    return TopBarAgnosticNoIcon(
      text: "Upgrade Screen",
      style: kSendButtonTextStyle,
      uniqueHeroTag: 'upgrade_screen1',
      child: Scaffold(
          backgroundColor: kColorPrimary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Icon(
                    Icons.error,
                    color: kColorText,
                    size: 44.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "There was an error. Please check that your device is allowed to make purchases and try again. Please contact us at xxx@xxx.com if the problem persists.",
                    textAlign: TextAlign.center,
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
