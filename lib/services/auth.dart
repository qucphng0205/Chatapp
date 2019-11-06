import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  Stream<FirebaseUser> get getUser {
    return _auth.onAuthStateChanged; 
  } 

  Future signInAsAnonymous() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      user = result.user;
      return user;
    } catch (e) {
      print("this?");
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      print('Cannot sign out');
      return null;
    }
  }

  String getEmail() {
    return user.email;
  }
}
