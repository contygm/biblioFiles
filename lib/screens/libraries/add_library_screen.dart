import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../db/databaseops.dart';
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
    return Form(
        key: _key,
        child: Column(children: [
          TextFormField(
              decoration: const InputDecoration(labelText: 'Library Name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'A new library requires a name!';
                }
                name = value;
                return null;
              }),
          RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'libraries');
              },
              child: Text('View libraries')),
          RaisedButton(
              onPressed: () async {
                if (_key.currentState.validate()) {
                  //submit info to db and navigate to libraries
                  await callCreateLibrary(name, uid);
                  final message =
                      SnackBar(content: Text('Library has been added!'));
                  Scaffold.of(context).showSnackBar(message);
                }
              },
              child: Text('Save'))
        ]));
  }
}
