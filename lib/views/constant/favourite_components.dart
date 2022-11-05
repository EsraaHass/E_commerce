import 'package:flutter/material.dart';

class FavouriteIcon extends StatefulWidget {
  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      child: DecoratedBox(
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 2)
            ],
            //border: Border.all(color: Colors.grey.shade50),
            shape: BoxShape.circle,
            color: Colors.white),
        child: IconButton(
          padding: EdgeInsets.only(right: 1, left: 2, top: 5),
          onPressed: () {
            setState(() {
              isFavourite = !isFavourite;
            });
          },
          icon: Icon(
            isFavourite ? Icons.favorite : Icons.favorite_border,
            size: 22,
            color: isFavourite ? Colors.red : Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
