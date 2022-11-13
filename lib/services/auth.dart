import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<User?> loginWithEmailAndPassword(String email, String password);

  Future<User?> signUpWithEmailAndPassword(String email, String password);

  User? get currentUser;

  Stream<User?> authStatesChanges();

  Future<void> logOut();
}

class Auth implements AuthBase {
  final auth = FirebaseAuth.instance;

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Stream<User?> authStatesChanges() => auth.authStateChanges();

  @override
  User? get currentUser => auth.currentUser;

  @override
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<void> logOut() async => await auth.signOut();
}
