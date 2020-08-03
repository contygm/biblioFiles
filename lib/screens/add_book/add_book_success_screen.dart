import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../templates/default_template.dart';

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
                Navigator.pushNamed(context, 'libraryBooks',
                    arguments: (libId));
              },
              child: Text('Go to Library'),
            ),
          ],
        )
      ],
    );
  }
}
