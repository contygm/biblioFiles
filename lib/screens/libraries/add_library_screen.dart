import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../db/databaseops.dart';
import '../../styles.dart';
import '../../templates/default_template.dart';

class AddLibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: AddLibrary());
  }
}

class AddLibrary extends StatefulWidget {
  @override
  _AddLibraryState createState() => _AddLibraryState();
}

class _AddLibraryState extends State<AddLibrary> {
  String uid;
  // get UID
  void getUserId() async {
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    uid = user.uid;
  }

  initState() {
    getUserId();
  }

  final _key = GlobalKey<FormState>();
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _key,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Library Name',
                labelStyle: TextStyle(color: Styles.green),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Styles.darkGreen
                  )
                )
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'A new library requires a name!';
                }
                name = value;
                return null;
              }
            ),
            buttonRow(),
          ]
        )
      ),
    );
  }

  Widget buttonRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        children: [
          ButtonTheme(
            buttonColor: Styles.darkGreen,
            minWidth: (MediaQuery.of(context).size.width * 0.25),
            height: (MediaQuery.of(context).size.width * 0.12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: RaisedButton(
              elevation: 3,
              onPressed: () {
                Navigator.pushNamed(context, 'libraries');
              },
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: FaIcon(FontAwesomeIcons.book, color: Styles.offWhite)
                  ),
                  Text('View libraries', 
                    style: Styles.smallWhiteButtonLabel,
                    textAlign: TextAlign.center
                  ),
                ],
              )
            )
          ),
          ButtonTheme(
            buttonColor: Styles.yellow,
            minWidth: (MediaQuery.of(context).size.width * 0.3),
            height: (MediaQuery.of(context).size.width * 0.12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: RaisedButton(
              elevation: 3,
              onPressed: () async {
                if (_key.currentState.validate()) {
                  //submit info to db and navigate to libraries
                  await callCreateLibrary(name, uid);
                  final message =
                      SnackBar(content: Text('Library has been added!'));
                  Scaffold.of(context).showSnackBar(message);
                }
              },
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
          )
        ]
      ),
    );
  }
}
