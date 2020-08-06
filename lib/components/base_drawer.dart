import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/settings/settings_screen.dart';

class BaseDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getProfileName(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var _opac;
            var _visible;
            if (snapshot.data != '') {
              _opac = 1.0;
              _visible = false;
            } else {
              _opac = .25;
              _visible = true;
            }

            return Drawer(
                key: Key('sideMenu'),
                child: ListView(
                  children: <Widget>[
                    Visibility(
                      visible: _visible,
                      child: Text(
                        'Sign in for these options',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Color.fromRGBO(255, 0, 0, 1),
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: _opac,
                      child: ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                        onTap: () {
                          if (snapshot.data != '') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Opacity(
                      opacity: _opac,
                      child: ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text(
                            snapshot.data == '' ? 'Profile' : snapshot.data),
                        onTap: () {
                          if (snapshot.data != '') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()),
                            );
                          }
                        },
                      ),
                    ),
                    Divider(),
                    Opacity(
                      opacity: _opac,
                      child: ListTile(
                        title: Text('Signout'),
                        onTap: () async {
                          if (snapshot.data != '') {
                            var name = await getProfileName();
                            if (name != 'Profile') {
                              FirebaseAuth.instance.signOut();

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            }
                          }
                        },
                      ),
                    ),
                     Opacity(
                      opacity: _opac,
                      child: ListTile(
                        title: Text('Home'),
                        onTap: ()  {
                              Navigator.pushNamed(context, 'home');
                            }
                      ),
                    ),
                  ],
                ) // Populate the Drawer in the next step.
                );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<String> getProfileName() async {
    // get UID
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    if (user != null) {
      return user.displayName;
    } else {
      return '';
    }
  }
}
