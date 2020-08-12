import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../db/databaseops.dart';
import '../../models/bookLibrary.dart';
import '../../styles.dart';
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
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text('Save some info about who\'s checking out your book', 
                style: Styles.darkGreenMediumText,
                textAlign: TextAlign.center,),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'First Name', 
                  labelStyle: TextStyle(color: Styles.green),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Styles.darkGreen
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Styles.green
                    )
                  )
                ),
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
                  labelText: 'Last Name', 
                  labelStyle: TextStyle(color: Styles.green),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.darkGreen
                        )
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.green
                        )
                      )
              ),
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
              labelText: 'Phone', 
              labelStyle: TextStyle(color: Styles.green),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Styles.darkGreen
                )
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Styles.green
                )
              )
            ),
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
              labelText: 'Email', 
              labelStyle: TextStyle(color: Styles.green),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Styles.darkGreen
                )
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Styles.green
                )
              )
            ),
            onSaved: (value) {
              email = value;
              //print('email');
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
      ),
    ));
  }

  Widget saveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonTheme(
          buttonColor: Styles.yellow,
          minWidth: (MediaQuery.of(context).size.width * 0.25),
          height: (MediaQuery.of(context).size.width * 0.12),
          shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
          ),
          child: RaisedButton(
            elevation: 3,
            onPressed: () => saveAndGoToList(context),
            child: Row(
              children:[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FaIcon(FontAwesomeIcons.solidSave, 
                    color: Styles.offWhite, 
                    size: MediaQuery.of(context).size.width * 0.05),
                ),
                Text('Save', 
                  style: Styles.smallWhiteBoldButtonLabel,
                  textAlign: TextAlign.center
                ),
              ],
            )
          )
    )]);
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
