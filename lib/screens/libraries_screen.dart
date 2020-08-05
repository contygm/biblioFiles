import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../templates/default_template.dart';
import '../db/databaseops.dart';
import '../models/library.dart';

class LibraryArgs {
  final int id;
  final String name;

  LibraryArgs(this.id, this.name);
}

class LibrariesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: new LoadLibrary());
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
    List<Library> libraries = await callGetLibraries(uid);
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
              DropdownButtonFormField<Library>(
                          decoration:
                              InputDecoration(labelText: 'Select a Library'),
                          value: selectedLibrary,
                          onChanged: (newValue) {
                            setState(() {
                              selectedLibrary = newValue;
                            });
                          },
                          items: finalLibraries
                              .map((item) => DropdownMenuItem<Library>(
                                    child: Text(item.libraryName),
                                    value: item,
                                  ))
                              .toList()),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                RaisedButton(
                    onPressed: () async {
                     
                      Navigator.pushNamed(context, 'libraryBooks',
                          arguments: 
                          LibraryArgs(selectedLibrary.id, 
                            selectedLibrary.name));
                    },
                    child: Text('View')),
                RaisedButton(
                    onPressed: () async {
                      await callDeleteLibrary(selectedLibrary.id);
                      Navigator.pushNamed(
                        context,
                        'libraries',
                      );

                      setState(() {});
                    },
                    child: Text('Delete'))
              ]),
              RaisedButton(
                child: Text('Create Library'),
                onPressed: () {
                  Navigator.pushNamed(context, 'addLibrary');
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
                Navigator.pushNamed(context, 'addLibrary');
              })
        ],
      ));
    }
  }
}
