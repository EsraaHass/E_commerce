import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/views/constant/theme.dart';
import 'package:ecommerce/views/pages/BottomNaveBar.dart';
import 'package:ecommerce/views/pages/homeScreen/product_details.dart';
import 'package:ecommerce/views/pages/login/Login.dart';
import 'package:ecommerce/views/pages/register/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var product = ModalRoute.of(context)?.settings.arguments as Product ;
    return Provider<AuthBase>(
      create: (_) => Auth(),
      child: MaterialApp(
          theme: MyTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: Login.routeName,
          routes: {
            Login.routeName: (_) => Login(),
            Register.routeName: (_) => Register(),
            BottomNaveBar.routeName: (_) => BottomNaveBar(),
            //LandingPage.routeName: (_) => LandingPage(),
            ProductDetails.routeName: (_) => ProductDetails(),
          }),
    );
  }
}
