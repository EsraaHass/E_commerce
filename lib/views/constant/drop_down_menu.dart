import 'package:flutter/material.dart';

class DropDowmNenu extends StatefulWidget {
  List<String> list = ['S', 'M', 'L', 'XL', 'XXL'];
  late String dropdownValue;

  @override
  State<DropDowmNenu> createState() => _DropDowmNenuState();
}

class _DropDowmNenuState extends State<DropDowmNenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: null,
      hint: const Text('Size'),
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      items: widget.list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          widget.dropdownValue = value!;
        });
      },
    );
  }
}
