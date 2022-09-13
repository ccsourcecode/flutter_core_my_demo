import 'dart:math';

import 'package:flutter/material.dart';

import 'components.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'upgrade.dart';

/// block access to certain users. This is a requirement on iOS if you develop apps for kids.
/// A parental gate presents an adult-level challenge that must be completed in order to continue
/// present a random math question and allow the user to move on to the next screen if the answer is correct
class ParentalGate extends StatefulWidget {
  const ParentalGate({Key? key}) : super(key: key);

  @override
  _ParentalGateState createState() => _ParentalGateState();
}

class _ParentalGateState extends State<ParentalGate> {
  String? answer;
  int firstNumber = 0;
  int secondNumber = 0;
  String? solution;
  final myController = TextEditingController();

  void solvePuzzle() {
    firstNumber = generateRandomNumbers();
    secondNumber = generateRandomNumbers();
    solution = (firstNumber + secondNumber).toString();
    setState(() {});
  }

  generateRandomNumbers() {
    int min = 11;
    int max = 95;
    print('max is $max');
    int randomNumber = min + (Random().nextInt(max - min));
    return randomNumber;
  }

  @override
  void initState() {
    firstNumber = generateRandomNumbers();
    secondNumber = generateRandomNumbers();
    solution = (firstNumber + secondNumber).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TopBarAgnosticNoIcon(
      text: 'Parental Gate',
      style: kSendButtonTextStyle,
      uniqueHeroTag: 'parental_gate',
      child: Scaffold(
        backgroundColor: kColorPrimary,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Hero(
                      tag: 'logo',
                      child: CircleAvatar(
                        backgroundColor: kColorPrimary,
                        radius: 50.0,
                        backgroundImage:
                            AssetImage("assets/images/avatar_demo.png"),
                      ),
                    ),
                  ),
                  Text(
                    'Ask parent/guarding for help',
                    textAlign: TextAlign.center,
                    style: kSendButtonTextStyle,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'Please hand over the device to a parent or a guardian to continue.',
                    style: kSendButtonTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'How much is ${firstNumber.toString()} plus ${secondNumber.toString()}?',
                          textAlign: TextAlign.center,
                          style: kSendButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: kSendButtonTextStyle,
                    controller: myController,
                    autofocus: true,
                    onChanged: (value) {
                      answer = value;
                    },
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          textStyle: MaterialStateProperty.all(
                              const TextStyle(color: kColorText)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Confirm',
                            style: kSendButtonTextStyle,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            myController.text = '';
                          });
                          if (answer == solution) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpgradeScreen(),
                                  settings: const RouteSettings(
                                      name: 'Upgrade screen'),
                                ));
                          } else {
                            //try again

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
                                      'This is not correct. Please try again.',
                                      textAlign: TextAlign.center,
                                      style: kSendButtonTextStyle.copyWith(
                                          fontSize: 19, color: kColorText),
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
                                    solvePuzzle();
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
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
