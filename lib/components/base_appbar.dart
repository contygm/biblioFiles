import 'package:flutter/material.dart';

// NOTE: See Answer for 'How to make your own AppBar' -> 
// -> https://stackoverflow.com/questions/53411890/how-can-i-have-my-appbar-in-a-separate-file-in-flutter-while-still-having-the-wi

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar appBar;
  BaseAppBar({Key key, this.appBar}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  @override
  _BaseAppBarState createState() => _BaseAppBarState();
}

class _BaseAppBarState extends State<BaseAppBar> {
  
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text( 'BiblioFiles' );
  
  final TextEditingController _searchController = TextEditingController();

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
    return AppBar(
      title: _appBarTitle,
      leading: Padding(
        padding: EdgeInsets.only(left: 6),
        child: IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,
        ),
      ),
    );
  }
}