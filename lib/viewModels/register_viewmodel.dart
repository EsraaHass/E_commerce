import 'package:ecommerce/models/my_user.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/viewModels/database_viewmodel.dart';
import 'package:ecommerce/views/constant/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/firestore_services.dart';
import '../views/pages/base/base.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void goToHome();
}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  AuthBase? authBase;
  final auth = FirebaseAuth.instance;
  String email;
  String password;
  final database = DatabaseViewModel();
  final services = FirestoreServices.instance;

  RegisterViewModel({this.authBase, this.password = '', this.email = ''});

  copyWith({String? email, String? password}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
  }

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);

  void createAccount() async {
    navigator?.showLoading();
    try {
      var cerdintial = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      MyUser myUser = MyUser(id: cerdintial.user?.uid, email: email);
      MyUser? result = await services.setUserData(myUser);
      navigator?.hideLoading();

      navigator?.goToHome();
      if (result != null) {
        SharedData.myUser = result;
        navigator?.goToHome();
      } else {
        navigator
            ?.showMessage('something went wrong with username or password');
      }

      // navigator?.goToHome();
      //SharedData.myUser?.id = cerdintial?.uid ;

      // var insertedUser = await database.setUserData(myUser);
      //  navigator?.hideLoading();
      //  if (insertedUser != null) {
      //
      //    navigator?.goToHome();
      //   // SharedData.myUser = insertedUser;
      //  } else {
      //    navigator
      //        ?.showMessage('something went wrong with username or password');
      //  }
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

// void loginWithFacebook()async{
//   FacebookLogin facebookLogin = FacebookLogin();
//  FacebookLoginResult result=  await facebookLogin.logIn(customPermissions: ['email']);
// final accessToken= result.accessToken?.token;
// if(result.status == FacebookLoginStatus.success){
//   final facecerdintial = FacebookAuthProvider.credential(accessToken!);
//   await auth.signInWithCredential(facecerdintial);
// }
// }
}

/*
import 'package:ecommerce/models/my_user.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/viewModels/database_viewmodel.dart';
import 'package:ecommerce/views/constant/constant.dart';
import 'package:ecommerce/views/constant/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../views/pages/base/base.dart';

abstract class RegisterNavigator extends BaseNavigator {
  void goToHome();
}

class RegisterViewModel extends BaseViewModel<RegisterNavigator> {
  AuthBase? authBase;

  String email;
  String password;
  final database = DatabaseViewModel();

  RegisterViewModel({this.authBase, this.password = '', this.email = ''});

  copyWith({String? email, String? password}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
  }

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);

  void createAccount() async {
    navigator?.showLoading();
    try {
      var cerdintial =
          await authBase?.signUpWithEmailAndPassword(email, password);

      MyUser myUser = MyUser(
          id: cerdintial?.uid,
          email: email
      );
      var result= await database.setUserData(myUser);
      SharedData.myUser = result ;

      print('the current id = ${SharedData.myUser?.id}');

      navigator?.goToHome();
      //SharedData.myUser?.id = cerdintial?.uid ;


     // var insertedUser = await database.setUserData(myUser);
     //  navigator?.hideLoading();
     //  if (insertedUser != null) {
     //
     //    navigator?.goToHome();
     //   // SharedData.myUser = insertedUser;
     //  } else {
     //    navigator
     //        ?.showMessage('something went wrong with username or password');
     //  }
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
  }}
 */
