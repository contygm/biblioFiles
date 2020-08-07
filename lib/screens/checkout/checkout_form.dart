import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../templates/default_template.dart';

class CheckoutForm extends StatefulWidget {
  @override
  _CheckoutFormState createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
        content: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
                decoration: InputDecoration(
                    labelText: 'First Name', border: OutlineInputBorder()),
                onSaved: (value) {
                  print('first name');
                },
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  // ignore: deprecated_member_use
                  BlacklistingTextInputFormatter(RegExp("[0123456789]"))
                ]),
            Divider(),
            TextFormField(
                decoration: InputDecoration(
                    labelText: 'Last Name', border: OutlineInputBorder()),
                onSaved: (value) {
                  print('Last name');
                },
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  // ignore: deprecated_member_use
                  BlacklistingTextInputFormatter(RegExp("[0123456789]"))
                ]),
            Divider(),
            TextFormField(
                decoration: InputDecoration(
                    labelText: 'Phone', border: OutlineInputBorder()),
                onSaved: (value) {
                  print('phone');
                },
                keyboardType: TextInputType.phone,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ]),
            Divider(),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
              onSaved: (value) {
                print('email');
              },
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isNotEmpty) {
                  Pattern pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  var regex = RegExp(pattern);
                  return (!regex.hasMatch(value)) ? 'Invalid email' : null;
                }
                return null;
              },
            ),
            Divider(),
            saveButton(context)
          ])),
    ));
  }

  Widget saveButton(BuildContext context) {
    return RaisedButton(
        child: Text('Save', style: Theme.of(context).textTheme.headline6),
        onPressed: () => saveAndGoToList(context));
  }

  void saveAndGoToList(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Navigator.of(context).pop();
    }
  }
}
