import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in as guest
  Future signInGuest() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user;
    } catch(e){
      return e.message;
    }
  }

  //sign in with email/pass
  Future<void> signInUser(String email, String password) async{
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'wrong-password'){
        print("Wrong password");
      }
    }

  }

  //sign up email/pass
  Future<bool> signUpUser(String email, String password) async{
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'weak-password'){
        print("Password is too weak");
      }
      else if(e.code == 'email-already-in-use'){
        print("Email already in use");
      }
      return false;
    }
  }

  //sign out
  void signOut() {

  }

}