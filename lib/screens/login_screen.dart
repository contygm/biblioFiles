import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/logo_card.dart';
import '../services/auth.dart';
import '../templates/default_template.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return DefaultTemplate(
      content: Column(
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
            onPressed: () async {
              if(authService.user != null) {
                pushHome(context);
              } else if(await authService.signInWithGoogle() != null) {
                pushHome(context);
              } else {
                Scaffold.of(context).showSnackBar(const SnackBar(
                  content: Text('Oops, something went wrong! Try Again!'),
                ));
              }
              
            },
          )
        ]
      )
    );
  }

  void pushHome(BuildContext context) {
    Navigator.of(context).pushNamed( 'home' );
  }
}

