import 'package:ecommerce/controllers/login_controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/main_button.dart';
import '../register/register.dart';

class Login extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  bool password = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginControllers>(
        create: (_) => LoginControllers(),
        child: Consumer<LoginControllers>(
          builder: (_, controller, __) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
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
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(passwordFocusNode),
                          textInputAction: TextInputAction.next,
                          controller: emailcontroller,
                          onChanged: controller.updateEmail,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter email';
                            }
                            return null;
                          },
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
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
                          onChanged: controller.updatePassword,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter password';
                            }
                            if (text.length < 6) {
                              return 'password should be at least 6 chars';
                            }
                            return null;
                          },
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15),
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
                              login(controller);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Register()));
                              },
                              child:
                                  const Text('Don\'t Have Account? Register')),
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
            );
          },
        ));
  }

  Future<void> login(LoginControllers controllers) async {
    if (formKey.currentState!.validate()) {
      await controllers.login();
    }
  }
}
