import 'package:ecommerce/controllers/firestore_controllers.dart';
import 'package:ecommerce/models/my_user.dart';
import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/views/constant/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../services/firestore_services.dart';

class RegisterControllers with ChangeNotifier {
  AuthBase? authBase;
  String email;
  String password;
  final services = FirestoreServices.instance;
  final auth = FirebaseAuth.instance;
  final database = FirestoreDataBase('123');

  RegisterControllers(
      {required this.authBase, this.email = '', this.password = ''});

  copyWith({String? email, String? password}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
  }

  void updateEmail(String email) => copyWith(email: email);

  void updatePassword(String password) => copyWith(password: password);

  Future<void> creatAccount() async {
    try {
      final user = await authBase?.signUpWithEmailAndPassword(email, password);
      final myUser = MyUser(
        id: user?.uid ?? idFromLocalData(),
        email: email,
      );
      await database.setUserData(myUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('something went wrong, please try again.');
    }
  }
}
