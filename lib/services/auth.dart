import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> user;
  Stream<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  Future<FirebaseUser> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn().catchError((onError) {
            print("error $onError");
          });;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final user =
        (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    
    return user;
  }

  void signOut() async {
      await _auth.signOut();
  }
}

final AuthService authService = AuthService();