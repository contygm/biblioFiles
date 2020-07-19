import 'package:flutter/material.dart';
import 'login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // Search related variables
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text( 'BiblioFiles' );
  final TextEditingController _searchController = TextEditingController();

  // search functionality
  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = Icon(Icons.close);
        _searchText = _searchController.text;
        _appBarTitle = TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
          onSubmitted: (value) {
            _searchText = _searchController.text;
            print("SEARCH Input: $_searchText");
          },
        );
      } else {
        _searchController.text = "";
        _searchIcon = Icon(Icons.search);
        _appBarTitle = Text('BiblioFiles');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
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
      ),
      appBar: AppBar(
        title: _appBarTitle,
        leading: Padding(
          padding: EdgeInsets.only(left: 6),
          child: IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed,
          ),
        ),
      ),
      body: SafeArea(
        child: Login()
      )
    );
  }
}