import 'package:flutter/material.dart';

class BaseDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigator.pop(context);
              print('Clicked SETTINGS');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {
              // Navigator.pop(context);
              print('Clicked PROFILE');
            },
          ),
          Divider(),
          ListTile(
            title: Text('Signout'),
            onTap: () {
              // Navigator.pop(context);
              print('Clicked SIGNOUT');
            },
          )
        ],
      )// Populate the Drawer in the next step.
    );
  }
}