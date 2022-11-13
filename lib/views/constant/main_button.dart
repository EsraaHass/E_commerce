import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  String text;

  VoidCallback voidCallback;

  MainButton({required this.text, required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: voidCallback,
          child: Text(text)),
    );
  }
}
