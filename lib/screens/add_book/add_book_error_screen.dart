import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../templates/default_template.dart';
import 'add_book_start_screen.dart';

class AddBookErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(content: AddError());
  }
}

class AddError extends StatefulWidget {
  @override
  _AddError createState() => _AddError();
}

class _AddError extends State<AddError> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Oops! Looks like something went wrong!'),
        RaisedButton(
          child: Text('Try Again'),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddBookScreen()));
          },
        ),
      ],
    );
  }
}
