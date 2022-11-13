import 'package:ecommerce/services/auth.dart';
import 'package:ecommerce/views/constant/main_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Future<void> logout(AuthBase model, context) async {
    try {
      await model.logOut();
      Navigator.pop(context);
    } catch (e) {
      debugPrint('logout error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthBase>(
      builder: (_, model, __) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.orange,
              child: MainButton(
                  text: 'LogOut',
                  voidCallback: () {
                    logout(model, context);
                  }),
            ),
          ],
        );
      },
    );
  }
}
