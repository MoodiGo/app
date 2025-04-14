import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;
  

  FirebaseAuthService(this._auth);

  Future<UserCredential> signInWithEmail(String email, String password) {
    final userCredential = _auth.signInWithEmailAndPassword(email: email, password: password);
    print('User signed in: ${_auth.currentUser?.email}');
    return userCredential;
  }

  Future<UserCredential> signUpWithEmail(String email, String password) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
