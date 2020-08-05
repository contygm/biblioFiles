import 'package:flutter/material.dart';

import '../screens/settings/settings_screen.dart';
import '../screens/profile/profile_screen.dart';

class BaseDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        key: Key('sideMenu'),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Signout'),
              onTap: () async {
                // await authService.signOut();
                print('Clicked SIGNOUT');
              },
            )
          ],
        ) // Populate the Drawer in the next step.
        );
  }
}
