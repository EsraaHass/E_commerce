import 'package:flutter/material.dart';

class BuildHeaderOfList extends StatelessWidget {
  String text;
  String descrition;
  VoidCallback voidCallback;

  BuildHeaderOfList(this.text, this.descrition, this.voidCallback);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            InkWell(
              child: Text(
                'View All',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.grey[600], fontSize: 17),
              ),
              onTap: voidCallback,
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          descrition,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: Colors.grey[500]),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
