import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../styles.dart';
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text("Oops! Looks like something went wrong!",
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
                    onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddBookScreen()));
                    },
                    child: Row(
                      children:[
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: FaIcon(FontAwesomeIcons.redo, 
                            color: Styles.offWhite, 
                            size: MediaQuery.of(context).size.width * 0.05),
                        ),
                        Text('Try Again', 
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
}
