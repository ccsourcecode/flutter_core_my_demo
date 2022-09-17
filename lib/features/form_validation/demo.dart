import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class FormValiadtionView extends StatefulWidget {
  @override
  _FormValiadtionViewState createState() => _FormValiadtionViewState();
}

class _FormValiadtionViewState extends State<FormValiadtionView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState?.save();
            }
          },
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              keyboardType: TextInputType.text,
              onSaved: (value) => _name = value,
              validator: (value) {
                if (value!.length < 2) {
                  return 'Name not long enough';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (!EmailValidator.validate(value!)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Mobile'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                var potentialNumber = int.tryParse(value!);
                if (potentialNumber == null) {
                  return 'Enter a phone number';
                }
                return null;
              },
            ),
          ]),
        ));
  }
}
