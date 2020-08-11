import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../db/databaseops.dart';
import '../../models/user.dart';
import '../../styles.dart';
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
            child: SingleChildScrollView(
              child: Padding(
                padding:const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                      child: Text('Profile Info', 
                        style: Styles.header2DarkGreenStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: (snapshot.data.photoURL.length > 1 ? 
                        Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(snapshot.data.photoURL),
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.8,
                        )
                        : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Container(
                            color: Styles.darkGreen,
                            child: Icon(Icons.person, 
                              color: Styles.offWhite, 
                              size: 200),
                          ),
                        )),
                    ),
                    TextFormField(
                      controller: _photoURLController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: 'Photo URL',
                        labelStyle: TextStyle(color: Styles.green),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Styles.darkGreen,
                          )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Styles.green
                          )
                        )
                      ),
                    ),
                    TextFormField(
                      controller: _userIdController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'User Id',
                        labelStyle: TextStyle(color: Styles.darkGrey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Styles.darkGrey,
                          )
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Styles.darkGrey
                          )
                        )
                      ),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'User Name',
                        labelStyle: TextStyle(color: Styles.green),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Styles.darkGreen,
                          )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Styles.green
                          )
                        )
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'User Email',
                        labelStyle: TextStyle(color: Styles.green),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Styles.darkGreen,
                          )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Styles.green
                          )
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: <Widget>[
                          ButtonTheme(
                            buttonColor: Styles.yellow,
                            minWidth: (MediaQuery.of(context).size.width * 0.25),
                            height: (MediaQuery.of(context).size.width * 0.12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: RaisedButton(
                              elevation: 3,
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
                              child: Row(
                                children:[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: FaIcon(FontAwesomeIcons.solidThumbsUp, 
                                      color: Styles.offWhite, 
                                      size: MediaQuery.of(context).size.width * 0.05),
                                  ),
                                  Text('Approve', 
                                    style: Styles.smallWhiteBoldButtonLabel,
                                    textAlign: TextAlign.center
                                  ),
                                ],
                              )
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
