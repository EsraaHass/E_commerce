import 'package:ecommerce/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../views/pages/base/base.dart';

abstract class LoginNavigator extends BaseNavigator {
  void goToHome();
}

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  AuthBase? authBase;
  String email;
  String password;

  LoginViewModel({this.authBase, this.password = '', this.email = ''});

  copyWith({String? email, String? password}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
  }

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);

  void login() async {
    navigator?.showLoading();
    try {
      var cerdintial =
          await authBase?.loginWithEmailAndPassword(email, password);

      // final userId = cerdintial?.uid ;
      // SharedData.id = userId ;

      navigator?.goToHome();
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoading();
      if (e.code == 'weak-password') {
        navigator?.showMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        navigator?.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage('something went wrong, please try again.');
    }
  }
}
