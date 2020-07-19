import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/logo_card.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

// TODO extract button
class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LogoCard(),
          RaisedButton.icon(
            icon: FaIcon(FontAwesomeIcons.google),
            label: Text('Sign in with Google'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () => print('Login Pressed'),
          )
        ]
      )
    );
  }
}

