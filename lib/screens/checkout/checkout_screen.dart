import 'package:biblioFiles/styles.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/library_dropdown.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';
import 'book_tile_list_screen.dart';

class CheckoutScreen extends StatefulWidget {
  static final String routeName = 'checkout';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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
        final formKey = GlobalKey<FormState>();
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: LibraryDropdown(
            formKey: formKey,
            selectedLibrary: selectedLibrary,
            finalLibraries: finalLibraries,
            onChanged: (value) {
              setState(() {
                selectedLibrary = value;
              });
            },
            viewColor: Styles.darkGreen,
            viewAction: () {
              if (formKey.currentState.validate()) {
                Navigator.of(context).pushNamed( 
                  BooksTileListScreen.routeName, 
                  arguments: selectedLibrary
                );
              }
            } 
          )
        );
      }
      //otherwise print empty screen
      return Container(
        child: Text('You can\'t checkout books from a non-existent library.')
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: dropDown(),
    );
  }
}
