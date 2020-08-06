import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';
import 'book_tile_list_screen.dart';

class CheckoutScreen extends StatelessWidget {
  static final String routeName = 'checkout';

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: LoadLibrary(), 
      floatingActionLocation: FloatingActionButtonLocation.centerDocked, 
      floatingAction: Container(
        height: 80.0,
        width: 80.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FittedBox(
            child: FloatingActionButton(
              child: Icon(Icons.arrow_right, size: 40.0),
              onPressed: () => Navigator.of(context)
                .pushNamed( BooksTileListScreen.routeName ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadLibrary extends StatefulWidget {
  @override
  _LoadLibraryState createState() => _LoadLibraryState();
}

class _LoadLibraryState extends State<LoadLibrary> {
  Library selectedLibrary;
  @override
  void initState() {
    super.initState();
    getLibraries();
  }

  List<Library> finalLibraries = [];
  bool lookLibrary = false;
  void getLibraries() async {
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;
    var libraries = await callGetLibraries(uid);
    setState(() {
      lookLibrary = true;
      finalLibraries = libraries;
    });
  }

  Widget build(BuildContext context) {
    if (lookLibrary == false) {
      return Container(child: CircularProgressIndicator());
    } else {
      if (finalLibraries.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
              DropdownButtonFormField<Library>(
                decoration: InputDecoration(labelText: 'Select a Library'),
                value: selectedLibrary,
                onChanged: (newValue) {
                  setState(() {
                    selectedLibrary = newValue;
                  });
                },
                items: finalLibraries.map((item) => 
                  DropdownMenuItem<Library>(
                    child: Text(item.libraryName),
                    value: item,
                  )).toList()
              ),
            ],
          ),
        );
      }
      //otherwise print empty screen
      return Container(
        child: Text('You can\'t checkout books from a non-existent library.')
      );
    }
  }
}
