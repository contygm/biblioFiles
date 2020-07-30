import 'package:flutter/material.dart';
import '../db/databaseops.dart';
import '../templates/default_template.dart';

class AddLibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: new AddLibrary());
  }
}

class AddLibrary extends StatefulWidget {
  @override
  _AddLibraryState createState() => _AddLibraryState();
}

class _AddLibraryState extends State<AddLibrary> {
  int userId = 19;

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
                  return 'A new library require a name!';
                }
                name = value;
                return null;
              }),
          RaisedButton(
              onPressed: () async {
                if (_key.currentState.validate()) {
                  //submit info to db and navigate to libraries
                  callCreateLibrary(name, userId);
                  await Navigator.pushNamed(context, 'libraries');
                }
              },
              child: Text('Save'))
        ]));
  }
}
