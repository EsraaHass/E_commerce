import 'package:ecommerce/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewModels/login_viewModel.dart';
import '../../constant/main_button.dart';
import '../BottomNaveBar.dart';
import '../base/base.dart';
import '../register/register.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends BaseState<Login, LoginViewModel>
    implements LoginNavigator {
  var formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  bool password = false;

  @override
  LoginViewModel initViewModel() {
    return LoginViewModel(authBase: Auth());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    focusNode: emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(passwordFocusNode),
                    textInputAction: TextInputAction.next,
                    controller: emailcontroller,
                    onChanged: viewModel.updateEmail,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter email';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter Your Email',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    focusNode: passwordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    controller: passwordcontroller,
                    onChanged: viewModel.updatePassword,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter password';
                      }
                      if (text.length < 6) {
                        return 'password should be at least 6 chars';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            password = !password;
                          });
                        },
                        child: password
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                      filled: true,
                      hintText: 'Enter Your Password',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {},
                        child: const Text('Forget Your Password ?')),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  MainButton(
                      text: 'Login',
                      voidCallback: () {
                        login();
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Register()));
                        },
                        child: const Text('Don\'t Have Account? Register')),
                  ),
                  const Spacer(),
                  const Align(
                      alignment: Alignment.center,
                      child: Text('Or Login With')),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 85,
                        height: 85,
                        child: Image.asset(
                          'images/google.jpg',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 85,
                        height: 85,
                        child: Image.asset(
                          'images/facebook.png',
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      viewModel.login();
    }
  }

  @override
  void goToHome() {
    formKey.currentState!.reset();
    Navigator.pushNamed(context, BottomNaveBar.routeName);
  }
}
