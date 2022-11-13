import 'package:ecommerce/controllers/register_controllers.dart';
import 'package:ecommerce/views/pages/BottomNaveBar.dart';
import 'package:ecommerce/views/pages/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/firestore_controllers.dart';
import '../../../services/auth.dart';

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
            return ChangeNotifierProvider<RegisterControllers>(
              create: (_) => RegisterControllers(authBase: auth),
              child: Register(),
            );
          }
          return ChangeNotifierProvider<RegisterControllers>(
            create: (_) => RegisterControllers(authBase: auth),
            child: Provider<Database>(
                create: (_) => FirestoreDataBase(user.uid),
                child: BottomNaveBar()),
          );
        }
        // TODO: We will refactor this to make one component for loading
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
