import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';
import 'library_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: Settings());
  }
}

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Library>>(
        future: getLibraries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: Icon(
                    Icons.edit,
                    size: 45,
                  ),
                  title: Text('${snapshot.data[index].libraryName}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return LibrarySettingsScreen(
                            libId: snapshot.data[index].libraryId);
                      }),
                    );
                  },
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<List<Library>> getLibraries() async {
    // get UID
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    final uid = user.uid;

    // get libraries from database
    var libraryObjects = await callGetLibraries(uid);

    // return libraries
    return libraryObjects;
  }
}
