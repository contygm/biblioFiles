import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../db/databaseops.dart';
import '../../models/user.dart';
import '../../templates/default_template.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: Profile());
  }
}

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: getProfileData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var _photoURLController =
              TextEditingController(text: snapshot.data.photoURL);
          var _usernameController =
              TextEditingController(text: snapshot.data.userUsername);
          var _emailController =
              TextEditingController(text: snapshot.data.userEmail);
          var _userIdController =
              TextEditingController(text: snapshot.data.userId);

          return Form(
            key: _key,
            child: Column(
              children: <Widget>[
                Image(image: NetworkImage(snapshot.data.photoURL)),
                TextFormField(
                  controller: _photoURLController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(labelText: 'Photo URL'),
                ),
                TextFormField(
                  controller: _userIdController,
                  readOnly: true,
                  decoration: InputDecoration(labelText: 'User Id'),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'User Name'),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'User Email'),
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () async {
                    // create new user object to save
                    var user = User(
                        _userIdController.text,
                        _usernameController.text,
                        _emailController.text,
                        _photoURLController.text);

                    // save user
                    await updateUser(user);

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<User> getProfileData() async {
    // get UID
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;

    // look up user
    var userObject = await getUser(uid);

    return userObject;
  }
}
