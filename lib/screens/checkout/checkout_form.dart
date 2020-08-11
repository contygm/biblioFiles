import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../db/databaseops.dart';
import '../../models/bookLibrary.dart';
import '../../templates/default_template.dart';

BookLibrary book; 

class CheckoutForm extends StatefulWidget {
  static final String routeName = 'checkoutForm';
  @override
  _CheckoutFormState createState() => _CheckoutFormState();
}

class _CheckoutFormState extends State<CheckoutForm> {
  var firstName = '';
  var lastName = '';
  var phone  = '';
  var email  = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    book = ModalRoute.of(context).settings.arguments;
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
                  firstName = value;
                  //print('first name');
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
                  lastName = value;
                  //print('Last name');
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
                  phone = value;
                 // print('phone');
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
               // email = value;
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

  void saveAndGoToList(BuildContext context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      var checkedOutNote =
          'Checked out to: $firstName $lastName, Phone: $phone, Email: $email';
      book.notes = checkedOutNote;
      book.checkedout = true;
      await updateLibraryBook(book);
      Navigator.of(context).pop();
    }
  }
}
