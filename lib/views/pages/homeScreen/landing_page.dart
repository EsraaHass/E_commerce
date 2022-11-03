import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/viewModels/database_viewmodel.dart';
import 'package:ecommerce/viewModels/login_viewModel.dart';
import 'package:ecommerce/views/constant/set_user.dart';
import 'package:ecommerce/views/pages/BottomNaveBar.dart';
import 'package:ecommerce/views/pages/login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  static const String routeName = 'LandingPage';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User?>(
        stream: auth.authStatesChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user == null) {
              SharedData.id = user?.uid;
              return ChangeNotifierProvider(
                  create: (_) => LoginViewModel(authBase: auth),
                  child: Login());
            }
            return Provider(
                create: (_) => DatabaseViewModel(uid: user.uid),
                child: BottomNaveBar());
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
