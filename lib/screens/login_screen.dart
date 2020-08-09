import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/logo_card.dart';
import '../services/auth.dart';
import '../styles.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String welcomeMsg = 'Welcome!';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Styles.blue, Styles.green ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: LogoCard(),
                  fit: FlexFit.tight,
                  flex: 2
                ),
                Flexible(
                  child: Text(welcomeMsg, 
                    style: TextStyle(
                      color: Styles.darkGrey,
                      fontSize: 30,
                      fontStyle: FontStyle.italic 
                    )
                  ),
                  fit: FlexFit.tight,
                  flex: 1
                ),
                Flexible(
                  child: loginLogic(),
                  fit: FlexFit.loose,
                  flex: 1
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  Future<String> getProfileName() async {
    // get UID
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    if (user != null) {
      welcomeMsg = 'Welcome back!';
      return user.displayName;
    } else {
      welcomeMsg = 'Welcome!';
      return '';
    }
  }

  void pushHome(BuildContext context) {
    Navigator.of(context).pushNamed('home');
  }

  Widget loginLogic() {
    return FutureBuilder<String>(
      future: getProfileName(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != '') {
            return loginButton(
              label: snapshot.data, 
              onPressed: () {
                pushHome(context);
              }
            );
          } else {
            return loginButton(
              label: 'Sign in with Google', 
              onPressed: () async {
                if (authService.user != null) {
                  pushHome(context);
                } else if (await authService.signInWithGoogle() != null) {
                  pushHome(context);
                } else {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('Oops, something went wrong! Try Again!'),
                  ));
                }
              }
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }

  Widget loginButton({String label, Function onPressed}) {
    return ButtonTheme(
      minWidth: (MediaQuery.of(context).size.width * 0.6),
      height: (MediaQuery.of(context).size.width * 0.15),
      padding: EdgeInsets.all(10.0),
      buttonColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Styles.darkGrey)
      ),
      child: RaisedButton.icon(
        icon: FaIcon(FontAwesomeIcons.google),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}
