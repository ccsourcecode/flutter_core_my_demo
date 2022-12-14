import 'package:flutter/material.dart';
import 'components.dart';

/// use this class to confirm that the user has already purchased a subscription
class ProScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TopBarAgnosticNoIcon(
      text: "Upgrade Screen",
      style: kSendButtonTextStyle,
      uniqueHeroTag: 'pro_screen',
      child: Scaffold(
          backgroundColor: kColorPrimary,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Icon(
                    Icons.star,
                    color: kColorText,
                    size: 44.0,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      "You are a Pro user.\n\nYou can use the app in all its functionality.\nPlease contact us at xxx@xxx.com if you have any problem",
                      textAlign: TextAlign.center,
                      style: kSendButtonTextStyle,
                    )),
              ],
            ),
          )),
    );
  }
}
