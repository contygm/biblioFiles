import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';
import 'settings_screen.dart';

class LibrarySettingsScreen extends StatelessWidget {
  final int libId;

  LibrarySettingsScreen({Key key, @required this.libId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: LibrarySettings(libId: libId));
  }
}

class LibrarySettings extends StatefulWidget {
  final int libId;

  LibrarySettings({this.libId});

  @override
  _LibrarySettings createState() => _LibrarySettings(libId: libId);
}

class _LibrarySettings extends State<LibrarySettings> {
  final _key = GlobalKey<FormState>();
  int libId;
  _LibrarySettings({this.libId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Library>(
      future: getLibraryData(libId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var _nameController =
              TextEditingController(text: snapshot.data.libraryName);
          var _idController =
              TextEditingController(text: snapshot.data.libraryId.toString());

          return Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _idController,
                  readOnly: true,
                  decoration: InputDecoration(labelText: 'Library Id'),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Library Name'),
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () async {
                    var library = Library(
                        _nameController.text, int.parse(_idController.text));

                    // save library
                    await updateLibrary(library);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<Library> getLibraryData(int libId) async {
    // look up user
    var libraryObject = await getLibrary(libId);

    return libraryObject;
  }
}
