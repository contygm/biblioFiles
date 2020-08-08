import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';
import 'checkbox_book_list.dart';

class UnpackScreen extends StatefulWidget {
  static final String routeName = 'unpack';
  final String nextRoute;

  UnpackScreen({Key key, this.nextRoute}) : super(key: key);

  @override
  _UnpackScreenState createState() => _UnpackScreenState();
}

class _UnpackScreenState extends State<UnpackScreen> {
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

  Widget dropDown() {
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
              RaisedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, CheckoutBookListScreen.routeName,
                    arguments: selectedLibrary
                  );
                },
                child: Text('View')
              )
            ],
          ),
        );
      }
      //otherwise print empty screen
      return Container(
        child: Text('You can\'t unpack books from a non-existent library.')
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: dropDown()
    );
  }
}
