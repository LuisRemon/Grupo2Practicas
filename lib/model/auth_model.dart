import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

// final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //
  // User? get currentUser => _firebaseAuth.currentUser;
  //
  // Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  //
  // Future<void> signInWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await _firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //   );
  // }
  //
  // Future<void> createUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password
  //   );
  // }
  //
  // Future<void> signOut() async {
  //   await _firebaseAuth.signOut();
  // }
}