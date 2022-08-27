import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email, username: user.displayName, photo: user.photoUrl) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }


  //sign in with Google
  Future signInWithGoogle() async{
    try{
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      print(account);
      if (account == null)
        return false;
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      // ignore: deprecated_member_use
      FirebaseUser user = res.user;
      print(user);
      //await DatabaseService().updateUserData(user.displayName, user.email, user.photoUrl);
      if(user == null)
        return false;
      // return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sigh out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}

class User{

  final String photo;
  final String uid;
  final String email;
  final String username;

  User({this.uid, this.email, this.photo, this.username});
}