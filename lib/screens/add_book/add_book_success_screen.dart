import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../styles.dart';
import '../../templates/default_template.dart';
import '../libraries/libraries_screen.dart';

class AddSuccessScreen extends StatelessWidget {
  final int libId;

  AddSuccessScreen({Key key, @required this.libId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: AddSuccess(libId: libId));
  }
}

class AddSuccess extends StatefulWidget {
  final int libId;
  AddSuccess({this.libId});
  @override
  _AddSuccess createState() => _AddSuccess(libId: libId);
}

class _AddSuccess extends State<AddSuccess> {
  int libId;
  _AddSuccess({this.libId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("You've added this book to your library!",
              textAlign: TextAlign.center,
              style: Styles.header2DarkGreenStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[
                ButtonTheme(
                  buttonColor: Styles.green,
                  minWidth: (MediaQuery.of(context).size.width * 0.25),
                  height: (MediaQuery.of(context).size.width * 0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: RaisedButton(
                    elevation: 3,
                    onPressed: () async {
                      var lib = await getLibraryName();
                      var libName = lib.libraryName;

                      Navigator.pushNamed(
                        context,
                        'libraryBooks',
                        arguments: LibraryArgs(libId, libName),
                      );
                    },
                    child: Row(
                      children:[
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: FaIcon(FontAwesomeIcons.warehouse, 
                            color: Styles.offWhite, 
                            size: MediaQuery.of(context).size.width * 0.05),
                        ),
                        Text('Go to Library', 
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
    );
  }

  Future<Library> getLibraryName() async {
    var libraryObject = await getLibrary(libId);

    return libraryObject;
  }
}
