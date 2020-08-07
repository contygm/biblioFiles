import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../db/databaseops.dart';
import '../../models/library.dart';
import '../../templates/default_template.dart';
import '../libraries_screen.dart';

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
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("You've added this book to your library!"),
            RaisedButton(
              onPressed: () async {
                var lib = await getLibraryName();
                var libName = lib.libraryName;

                Navigator.pushNamed(
                  context,
                  'libraryBooks',
                  arguments: LibraryArgs(libId, libName),
                );
              },
              child: Text('Go to Library'),
            ),
          ],
        )
      ],
    );
  }

  Future<Library> getLibraryName() async {
    var libraryObject = await getLibrary(libId);

    return libraryObject;
  }
}
