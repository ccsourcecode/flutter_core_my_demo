import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/services.dart';
import 'components.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PurchaseButton extends StatefulWidget {
  final Package package;

  const PurchaseButton({Key? key, required this.package}) : super(key: key);

  @override
  _PurchaseButtonState createState() => _PurchaseButtonState();
}

class _PurchaseButtonState extends State<PurchaseButton> {
  CustomerInfo? _customerInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        color: kColorPrimaryLight,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    print('now trying to purchase');
                    _customerInfo =
                        await Purchases.purchasePackage(widget.package);
                    print('purchase completed');

                    /* Restoring Purchases
                    CustomerInfo restoredInfo = await Purchases.restorePurchases();
                    bool isRestored = restoredInfo.entitlements.all["all_features"]!.isActive;
                    */

                    // Get Subscription Status
                    appData.isPro = _customerInfo!
                        .entitlements.all["all_features"]!.isActive;

                    print('is pro user? ${appData.isPro}');

                    if (appData.isPro!) {
                      Alert(
                        context: context,
                        style: kWelcomeAlertStyle,
                        image: Image.asset(
                          "assets/icon.png",
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
                                'Well done, you now have full access to the app',
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
                              Navigator.of(context, rootNavigator: true).pop();
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
                              Navigator.of(context, rootNavigator: true).pop();
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
                    var errorCode = PurchasesErrorHelper.getErrorCode(e);
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
                                top: 20.0, right: 8.0, left: 8.0, bottom: 20.0),
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
                            Navigator.of(context, rootNavigator: true).pop();
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
                // textColor: kColorText,
                // padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Buy ${widget.package.storeProduct.title}\n${widget.package.storeProduct.priceString}',
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
              child: Text(
                widget.package.storeProduct.description,
                textAlign: TextAlign.center,
                style: kSendButtonTextStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
