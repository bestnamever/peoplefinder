import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_ui_starter/models/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(id: user.uid) : null;
  }
  
  Future signIn(String email, String password) async {
    try {
        FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("wrong");
    }
  }

  Future signUp(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){}
  }
}
