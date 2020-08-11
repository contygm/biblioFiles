import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../styles.dart';
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

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _key,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                    child: Text('Update Library Info', 
                      style: Styles.header2DarkGreenStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextFormField(
                    controller: _idController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Library Id',
                      labelStyle: TextStyle(color: Styles.darkGrey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.darkGrey,
                        )
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.darkGrey
                        )
                      )
                    ),
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Library Name',
                      labelStyle: TextStyle(color: Styles.green),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.darkGreen,
                        )
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.green
                        )
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: <Widget>[
                        ButtonTheme(
                          buttonColor: Styles.yellow,
                          minWidth: (MediaQuery.of(context).size.width * 0.25),
                          height: (MediaQuery.of(context).size.width * 0.12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: RaisedButton(
                            elevation: 3,
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
                            child: Row(
                              children:[
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: FaIcon(FontAwesomeIcons.solidSave, 
                                    color: Styles.offWhite, 
                                    size: MediaQuery.of(context).size.width * 0.05),
                                ),
                                Text('Save', 
                                  style: Styles.smallWhiteBoldButtonLabel,
                                  textAlign: TextAlign.center
                                ),
                              ],
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
