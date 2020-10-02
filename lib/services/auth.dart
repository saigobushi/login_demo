import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_demo/models/user.dart';
import 'package:login_demo/services/auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj using FirebaseUser
  TheUser _userFromUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  Stream<TheUser> get user {
    return _auth.authStateChanges().map((User user) => _userFromUser(user));
  }

  // sign in anon
  Future signInAnon() async {
    try {
     UserCredential userCredential =  await _auth.signInAnonymously();
     User user = userCredential.user;
     return _userFromUser(user);
  } catch(e) {
    print(e.toString());
    return null;
  }

}

  // sign in email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _userFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // reg
    Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _userFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
}

  // sign out
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}