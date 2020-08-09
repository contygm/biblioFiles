import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/library_dropdown.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';

class LibraryArgs {
  final int id;
  final String name;

  LibraryArgs(this.id, this.name);
}

class LibrariesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: LoadLibrary());
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
        return Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LibraryDropdown(
                selectedLibrary: selectedLibrary,
                finalLibraries: finalLibraries,
                onChanged: (value) {
                  setState(() {
                    selectedLibrary = value;
                  });
                },
                viewAction: () async {
                  Navigator.pushNamed(context, 'libraryBooks',
                    arguments: LibraryArgs(
                      selectedLibrary.id, selectedLibrary.name));
                },
                includeDelete: true,
                deleteAction: () async {
                  await callDeleteLibrary(selectedLibrary.id);
                  Navigator.pushNamed(context, 'libraries');
                }
              ),
              RaisedButton(
                child: Text('Create Library'),
                onPressed: () {
                  Navigator.pushNamed(context, 'addLibrary');
                  setState(() {});
                },
              ),
            ],
          ),
        );
      }
      //otherwise print empty screen
      return Container(
        child: Column(
          children: [
            RaisedButton(
              child: Text('Create Library'),
              onPressed: () {
                lookLibrary = false;
                Navigator.pushNamed(context, 'addLibrary');
              }
            )
        ],
      ));
    }
  }
}
