import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Future<User?> loginWithEmailAndPassword(String email, String password);

 // Future<User?> signUpWithEmailAndPassword(String email, String password);

// MyUser? get currentUser;

// Stream<MyUser?> authStatesChanges();
}

class Auth implements AuthBase {
  final auth = FirebaseAuth.instance;

  // @override
  // Stream<MyUser?>  authStatesChanges() => auth.authStateChanges();

  // @override
  // MyUser? get currentUser => auth.currentUser;

  @override
  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    UserCredential credintial =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return credintial.user;
  }

// @override
// Future<User?> signUpWithEmailAndPassword(
//     String email, String password) async {
//   UserCredential credintial = await auth.createUserWithEmailAndPassword(
//       email: email, password: password);
//   return credintial.user;
// }
}
