import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/library_dropdown.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../styles.dart';
import '../../templates/default_template.dart';
import 'unpack_book_list.dart';

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
        final formKey = GlobalKey<FormState>();
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: LibraryDropdown(
            formKey: formKey,
            viewColor: Styles.darkGreen,
            selectedLibrary: selectedLibrary,
            finalLibraries: finalLibraries,
            onChanged: (value) {
              setState(() {
                selectedLibrary = value;
              });
            },
            viewAction: () async {
              if (formKey.currentState.validate()) {
                Navigator.pushNamed(context, CheckoutBookListScreen.routeName,
                  arguments: selectedLibrary
                );
              }
            },
          )
        );
      }
      //otherwise print empty screen
      return Container(child: Text('You don\'t have any libraries yet!', 
        style: Styles.header2Style));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: dropDown()
    );
  }
}
