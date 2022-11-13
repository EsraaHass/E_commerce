import 'package:ecommerce/controllers/register_controllers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant/main_button.dart';
import '../login/Login.dart';

class Register extends StatefulWidget {
  static const String routeName = 'Register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var formKey = GlobalKey<FormState>();
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var nameFocusNode = FocusNode();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  bool password = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterControllers>(
      builder: (_, registerController, __) {
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
                      'Register',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              TextFormField(
                                focusNode: nameFocusNode,
                                keyboardType: TextInputType.name,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(emailFocusNode),
                                textInputAction: TextInputAction.next,
                                controller: namecontroller,
                                validator: (text) {
                                  if (text == null || text.trim().isEmpty) {
                                    return 'please enter name';
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter Your Name',
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                focusNode: emailFocusNode,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: registerController.updateEmail,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(passwordFocusNode),
                                textInputAction: TextInputAction.next,
                                controller: emailcontroller,
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
                                obscureText: password,
                                onChanged: registerController.updatePassword,
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
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        password = !password;
                                      });
                                    },
                                    child: password
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Enter Your Password',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                        text: 'Register',
                        voidCallback: () {
                          register(registerController);
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                          child: const Text('Already Have Account? Login')),
                    ),
                    const Spacer(),
                    // SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                    const Align(
                        alignment: Alignment.center,
                        child: Text('Or Login With')),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
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
                        InkWell(
                          onTap: () {
                            //facebooklogin() ;
                          },
                          child: SizedBox(
                            width: 85,
                            height: 85,
                            child: Image.asset(
                              'images/facebook.png',
                              fit: BoxFit.fitHeight,
                            ),
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
    );
  }

  Future<void> register(RegisterControllers controllers) async {
    if (formKey.currentState!.validate()) {
      await controllers.creatAccount();
    }
  }

// void goToHome() {
//   formKey.currentState!.reset();
//   Navigator.pushNamed(context, BottomNaveBar.routeName);
// }
}
